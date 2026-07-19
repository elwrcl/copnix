{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  customKernel = pkgs.callPackage "${inputs.soryu-kernel}/kernel/kernel.nix" { };
in
{
  imports = [ ];

  environment.systemPackages = [ pkgs.efibootmgr ];

  boot.kernelPackages = pkgs.linuxPackagesFor customKernel;

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
      configurationLimit = 5;
    };
  };
}
