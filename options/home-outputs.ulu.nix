{ lib, ... }:
{
  options.flake.homeModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.deferredModule;
    default = { };
    description = "home-manager modul pool (symmetric with flake.nixosModules).";
  };
}
