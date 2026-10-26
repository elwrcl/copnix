{ ... }:
{
  flake.nixosModules.hw-udev =
    { ... }:
    {
      programs.gpu-screen-recorder.enable = true;
      services.udisks2.enable = true;
      services.gvfs.enable = true;
      # Passwordless mount/unlock/eject for wheel in the local active session
      # only; formatting, partitioning, secure erase etc. still ask.
      security.polkit.extraConfig = ''
        polkit.addRule(function(action, subject) {
            var allowed = [
                "org.freedesktop.udisks2.filesystem-mount",
                "org.freedesktop.udisks2.filesystem-mount-system",
                "org.freedesktop.udisks2.filesystem-unmount-others",
                "org.freedesktop.udisks2.encrypted-unlock",
                "org.freedesktop.udisks2.encrypted-unlock-system",
                "org.freedesktop.udisks2.eject-media",
                "org.freedesktop.udisks2.eject-media-system",
                "org.freedesktop.udisks2.power-off-drive",
                "org.freedesktop.udisks2.power-off-drive-system",
                "org.freedesktop.udisks2.loop-setup",
                "org.freedesktop.udisks2.rescan"
            ];
            if (allowed.indexOf(action.id) >= 0 &&
                subject.isInGroup("wheel") && subject.local && subject.active) {
                return polkit.Result.YES;
            }
        });
      '';
    };
}
