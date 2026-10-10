{ ... }:
{
  flake.nixosModules.hw-keychron =
    { pkgs, ... }:
    {
      services.udev.packages = [
        (pkgs.writeTextDir "lib/udev/rules.d/70-keychron.rules" ''
          KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", MODE="0660", TAG+="uaccess"
        '')
      ];
    };
}
