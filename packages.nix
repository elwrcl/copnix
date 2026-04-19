{ pkgs }:
let
  uxplay-fixed = pkgs.uxplay.override {
    avahi = pkgs.avahi.override { withLibdnssdCompat = true; };
  };
in
with pkgs;
{
  system = [
    # phone
    libmtp
    jmtpfs
    libimobiledevice
    ifuse
    kdePackages.krdp
    usbmuxd
    uxplay-fixed

    # vm
    virt-manager
    libvirt
    qemu

    # hardware
    xwayland-satelite
    ddcutil
    libsecret
    brightnessctl
    lm_sensors
    smartmontools
    gsmartcontrol
    parted
  ];
}
