{ ... }:
{
  flake.nixosModules.service-usbmuxd =
    { ... }:
    {
      # iOS device multiplexer: libimobiledevice, ifuse and xtool talk to an
      # iPhone over USB through this daemon (started by udev on plug-in).
      services.usbmuxd.enable = true;
    };
}
