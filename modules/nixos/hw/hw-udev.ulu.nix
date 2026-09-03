{ ... }:
{
  flake.nixosModules.hw-udev =
    { ... }:
    {
      programs.gpu-screen-recorder.enable = true;
      services.udisks2.enable = true;
      services.gnome.sushi.enable = true;
      services.gvfs.enable = true;
      security.polkit.extraConfig = ''
        polkit.addRule(function(action, subject) {
            if (action.id.match("org.freedesktop.udisks2.") &&
                subject.isInGroup("wheel")) {
                return polkit.Result.YES;
            }
        });
      '';
    };
}
