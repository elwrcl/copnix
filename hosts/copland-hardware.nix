{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "i915" ];
  boot.initrd.supportedFilesystems = [ "bcachefs" ];
  boot.kernelModules = [
    "kvm-intel"
    "ntsync"
    "hfsplus"
  ];
  boot.supportedFilesystems = [
    "hfsplus"
    "exfat"
    "bcachefs"
    "xfs"
  ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8cdde938-a457-4a54-976c-851cc72944b3";
    fsType = "bcachefs";
  };

  fileSystems."/mnt/HDD/linuxdata" = {
    device = "/dev/disk/by-uuid/9305cc87-d604-4c01-b597-a9ea8bdcaf66";
    fsType = "xfs";
    options = [
      "defaults"
      "nofail"
      "x-systemd.automount"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1B3D-5A7D";
    fsType = "vfat";
  };

  networking.useDHCP = lib.mkDefault true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
