{ ... }:
{
  flake.homeModules.home-radicle =
    {
      osConfig,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (lib.attrsets) optionalAttrs;
      hasSecret = (osConfig.age.secrets or { }) ? radicle-key;
    in
    {
      home.packages = [ pkgs.radicle-node ];
      home.file = {
        ".radicle/config.json".text = builtins.toJSON {
          publicExplorer = "https://radicle.network/nodes/$host/$rid$path";
          preferredSeeds = [
            "z6MkrLMMsiPWUcNPHcRajuMi9mDfYckSoJyPwwnknocNYPm7@iris.radicle.network:8776"
            "z6Mkmqogy2qEM2ummccUthFEaaHvyYmYBYh3dbe9W4ebScxo@rosa.radicle.network:8776"
          ];
        };
      }
      // optionalAttrs hasSecret {
        ".radicle/keys/radicle".source = osConfig.age.secrets.radicle-key.path;
      };
    };
}
