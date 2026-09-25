{ ... }:
{
  flake.nixosModules.common-boot =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.efibootmgr ];

      boot.tmp.cleanOnBoot = true;

      boot.loader = {
        timeout = 5;
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };

        systemd-boot = {
          enable = true;
          configurationLimit = 5;
          consoleMode = "max";
          editor = false;
        };
      };
    };
}
