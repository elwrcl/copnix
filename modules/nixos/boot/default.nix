{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  customKernel = inputs.soryu-kernel.packages.${pkgs.system}.customKernel;
in

{
  imports = [ ];
  environment.systemPackages = [ pkgs.efibootmgr ];

  # gentoo larp section
  boot.kernelPackages = pkgs.linuxPackagesFor customKernel;
  boot.kernelParams = [
    "preempt=full"
    "mitigations=off"
    "nmi_watchdog=1"
    "usbcore.autosuspend=-1"
    "ramoops.mem_size=8388608"
    "ramoops.record_size=524288"
    "transparent_hugepage=madvise"
  ];
  boot.kernelModules = [
    "tcp_bbr"
    "sch_fq"
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
}
