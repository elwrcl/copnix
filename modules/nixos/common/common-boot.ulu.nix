{ ... }:
{
  flake.nixosModules.common-boot =
    {
      pkgs,
      inputs,
      ...
    }:
    {
      environment.systemPackages = [ pkgs.efibootmgr ];
      boot.kernelPackages = pkgs.linuxPackages_latest;
      # todo soryu kernel, opsec modules ..
      boot.kernelParams = [
        "mitigations=off"
        "nmi_watchdog=1"
        "transparent_hugepage=madvise"
      ];

      boot.kernelModules = [
        "tcp_bbr"
        "sch_fq"
      ];

      hardware.i2c.enable = true;
      boot.kernel.sysctl = {
        "net.core.default_qdisc" = "fq";
        "net.ipv4.tcp_congestion_control" = "bbr";
        "kernel.softlockup_panic" = 1;
        "kernel.hardlockup_panic" = 1;
        "kernel.hung_task_panic" = 1;
        "kernel.panic" = 50;
      };

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
