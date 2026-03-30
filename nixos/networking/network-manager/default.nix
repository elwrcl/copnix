{ config, pkgs, ... }:

{
  networking.hostName = "copland";
  networking.networkmanager.enable = true;
}
