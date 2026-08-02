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
      home.file.".radicle/config.json".text = builtins.toJSON {
        publicExplorer = "https://radicle.network/nodes/$host/$rid$path";
        preferredSeeds = [
          "z6MkrLMMsiPWUcNPHcRajuMi9mDfYckSoJyPwwnknocNYPm7@iris.radicle.network:8776"
          "z6Mkmqogy2qEM2ummccUthFEaaHvyYmYBYh3dbe9W4ebScxo@rosa.radicle.network:8776"
        ];
      };
      home.activation = optionalAttrs hasSecret {
        radicleKey = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          run mkdir -p "$HOME/.radicle/keys"
          run ln -sf "${osConfig.age.secrets.radicle-key.path}" "$HOME/.radicle/keys/radicle"
        '';
      };
    };
}
