{ ... }:

{
  imports = [
    ../../modules/home
    ../../modules/home/linux.nix
  ];

  home.username = "elars";
  home.homeDirectory = "/home/elars";
  home.stateVersion = "25.05";
}
