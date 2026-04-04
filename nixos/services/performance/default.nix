{ config, pkgs, ... }:

{
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
  services.ananicy = {
    enable = false;
    package = pkgs.ananicy-cpp;
  };

  services.irqbalance.enable = true;
}
