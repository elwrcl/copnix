{ lib, ... }:

let
  env = import ./niri/env.nix;
  execs = import ./niri/execs.nix;
  general = import ./niri/general.nix;
  rules = import ./niri/rules.nix;
  keybinds = import ./niri/keybinds.nix;
in
{
  xdg.configFile."niri/config.kdl".text = lib.concatStringsSep "\n" [
    env
    execs
    general
    rules
    keybinds
  ];
}
