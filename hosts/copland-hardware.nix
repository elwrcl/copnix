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

  fileSystems."/mnt/HDD/shared" = {
    device = "/dev/disk/by-uuid/69F3-C5FB";
    fsType = "exfat";
    options = [
      "defaults"
      "nofail"
      "x-systemd.automount"
      "uid=1000"
      "gid=100"
      "umask=022"
    ];
  };

  fileSystems."/mnt/HDD/linuxdata" = {
    device = "/dev/disk/by-uuid/6acf076f-25a0-4ce1-b841-aefa8bb06218";
    fsType = "xfs";
    options = [
      "defaults"
      "nofail"
      "x-systemd.automount"
    ];
  };

  fileSystems."/mnt/macos-hd" = {
    device = "/dev/disk/by-uuid/4293fd0f-5237-4126-a072-4f2ae6c594dc";
    fsType = "fuse.apfs-fuse";
    options = [
      "ro"
      "nofail"
      "allow_other"
      "uid=1000"
      "gid=100"
      "x-systemd.automount"
    ];
  };

  fileSystems."/mnt/macos-data" = {
    device = "/dev/disk/by-uuid/1ae5a3f4-0aed-4de1-bcba-2976b891c4b1";
    fsType = "fuse.apfs-fuse";
    options = [
      "ro"
      "nofail"
      "allow_other"
      "uid=1000"
      "gid=100"
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
