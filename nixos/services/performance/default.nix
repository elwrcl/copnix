{ config, pkgs, ... }:

{
  services.scx = {
    enable = true;
    scheduler = "scx_rustland"; #you can find other schedulers to fit your needs
  };

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
  };

  services.irqbalance.enable = true;
}
