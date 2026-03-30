{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  boot.kernelParams = [
     "i915.enable_guc=2" #make your own params this is for hd4k
     "i915.fastboot=1"
     "mitigations=off"
     "usbcore.autosuspend=-1"
  ];
  boot.loader = {
    timeout = 5; 

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };

    systemd-boot = {
      enable = true;
      configurationLimit = 15; 
      consoleMode = "max";     
      editor = false;          
    };
  };
}
