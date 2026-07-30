{
  config,
  lib,
  moduleLocation,
  ...
}:
let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.lists) singleton;
  inherit (lib.modules) mkMerge;
  inherit (lib.options) mkOption;
  inherit (lib.types) deferredModule lazyAttrsOf;

  wrap =
    kind: name: value:
    let
      file = "${toString moduleLocation}#${kind}.${name}";
    in
    {
      _file = file;
      key = file;
      imports = singleton value;
    };
in
{
  options.commonModules = mkOption {
    type = lazyAttrsOf deferredModule;
    default = { };
    apply = mapAttrs (wrap "commonModules");
    description = "NixOS and Darwin modules shared between both platforms.";
  };

  config.flake.nixosModules = mkMerge [ config.commonModules ];
  config.flake.darwinModules = mkMerge [ config.commonModules ];
}
