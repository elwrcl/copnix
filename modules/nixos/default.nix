{ ... }:
{
  imports = [
    ../home/git.nix
    ./boot
    ./desktop
    ./editors/zed.nix
    ./gaming
    ./hardware
    ./networking
    ./services
    ./system
    ./users
    ./virtualization
  ];
}
