{ config, pkgs, ... }:

{
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  services.irqbalance.enable = true;
}
