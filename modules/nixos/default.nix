{ ... }:

{
  imports = [
    ../home/git.nix
    ./boot
    ./desktop
    ./gaming
    ./hardware
    ./networking
    ./overlays
    ./services
    ./system
    ./users
    ./virtualization
  ];
}
