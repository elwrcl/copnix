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

  boot.kernelPackages = pkgs.linuxPackagesFor customKernel;

  boot.kernelParams = [
    "netconsole=6665@192.168.1.105/enp8s0,6666@192.168.1.102/"
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
      configurationLimit = 5;
    };
  };
}
