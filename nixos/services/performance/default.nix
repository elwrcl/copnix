{ config, pkgs, ... }:

{
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
  services.irqbalance.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.geoclue2.enable = true;
}
