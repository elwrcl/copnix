{
  pkgs,
  ...
}:

{
  imports = [
  ];

  environment.systemPackages = [ pkgs.efibootmgr ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v2;

  boot.kernelParams = [
    "preempt=full"
    "mitigations=off"
    "usbcore.autosuspend=-1"
    "transparent_hugepage=madvise"
  ];

  boot.loader = {
    timeout = 5;
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot";
    };
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
  };
}
