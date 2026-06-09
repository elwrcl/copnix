{ pkgs, inputs, ... }:
{
  imports = [ ./niri/default.nix ];

  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
  };
}
