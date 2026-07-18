{ pkgs, inputs, ... }:

let
  lfbmqKernel = import ./kernel.nix { inherit pkgs; };
in
{
  imports = [ ];
  environment.systemPackages = [ pkgs.efibootmgr ];

  boot.kernelPackages = pkgs.linuxKernel.packagesFor lfbmqKernel;

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
