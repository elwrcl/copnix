{ ... }:
{
  flake.nixosModules.hw-udev =
    { ... }:
    {
      programs.gpu-screen-recorder.enable = true;
      services.udisks2.enable = true;
      services.gvfs.enable = true;
      security.polkit.extraConfig = ''
        polkit.addRule(function(action, subject) {
            if (action.id.match("org.freedesktop.udisks2.") &&
                subject.isInGroup("wheel")) {
                return polkit.Result.YES;
            }
        });
      '';
      services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="d030", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0b11", MODE="0660", TAG+="uaccess", TAG+="udev-acl"
      '';
    };
}
