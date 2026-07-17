{ pkgs, inputs, ... }:

{
  imports = [ ];

  environment.systemPackages = [ pkgs.efibootmgr ];

  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.default
  ];

  boot.kernelPackages =
    let
      kernel = pkgs.cachyosKernels.linux-cachyos-bmq.override {
        processorOpt = "x86_64-v2";
        lto = "full";
        bbr3 = true;
      };
    in
    pkgs.linuxKernel.packagesFor kernel;

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
