{ config, pkgs, ...}:

{
  programs.kdeconnect.enable = true;
  services.kdeconnect.enable = true;
}