{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [ ];
  environment.systemPackages = [ pkgs.efibootmgr ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto;

  boot.kernelParams = [
    "mitigations=off"
    "nmi_watchdog=1"
    "usbcore.autosuspend=-1"
    "ramoops.mem_size=8388608"
    "ramoops.record_size=524288"
    "transparent_hugepage=madvise"
    "loglevel=7"
  ];

  boot.kernelModules = [
    "tcp_bbr"
    "sch_fq"
    "ramoops"
    "netconsole"
  ];

  boot.extraModprobeConfig = ''
    options ramoops mem_size=8388608 record_size=524288
    options netconsole netconsole=6665@192.168.1.105/enp8s0,6666@192.168.1.101/82:31:f2:9f:73:40
  '';

  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "fq";
    "kernel.softlockup_panic" = 1;
    "kernel.hardlockup_panic" = 1;
    "kernel.hung_task_panic" = 1;
    "kernel.printk" = "8 4 1 7";
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
