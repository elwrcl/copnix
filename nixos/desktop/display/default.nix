{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.displayManager.ly.enable = true;

  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };
}
