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
    android-tools
    scrcpy
    libimobiledevice
    ifuse
    kdePackages.krdp
    usbmuxd
    uxplay-fixed

    # hardware
    ddcutil
    libsecret
    brightnessctl
    lm_sensors
    smartmontools
    gsmartcontrol
    exfatprogs
    hfsprogs
    gptfdisk
    usbutils
    p7zip
    dmg2img
    tree
    xar
    parted
  ];
}
