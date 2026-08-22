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

      nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto;
      # todo soryu kernel, opsec modules ..
      boot.kernelParams = [
        "mitigations=off"
        "nmi_watchdog=1"
        "transparent_hugepage=madvise"
        "reserve_mem=4M:4096:oops"
        "ramoops.mem_name=oops"
        "ramoops.record_size=262144"
        "ramoops.console_size=1048576"
        "ramoops.pmsg_size=65536"
        "ramoops.ecc=1"
      ];

      boot.kernelModules = [
        "tcp_bbr"
        "sch_fq"
        "ramoops"
      ];

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
