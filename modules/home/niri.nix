{ config, pkgs, inputs, ... }:

{
  imports = [ ./niri/default.nix ];

  programs.niri = {
    enable = true;
  };
}
