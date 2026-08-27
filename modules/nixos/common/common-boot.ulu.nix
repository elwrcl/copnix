{ ... }:
{
  flake.nixosModules.common-boot =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.efibootmgr ];

      boot.loader = {
        timeout = 5;
        efi = {
          canTouchEfiVariables = false;
          efiSysMountPoint = "/boot";
        };

        systemd-boot = {
          enable = true;
          configurationLimit = 5;
        };
      };
    };
}
