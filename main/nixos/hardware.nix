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
  boot.kernelModules = [
    "kvm-intel"
    "ntsync"
    "hfsplus"
  ];
  boot.supportedFilesystems = [
    "hfsplus"
    "exfat"
  ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7952dca8-005b-444c-a1eb-ecfbb5c053b2";
    fsType = "ext4";
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
    device = "/dev/disk/by-uuid/f7e27b90-ce06-48bb-b579-d93b1398b21f";
    fsType = "ext4";
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
