{ lib, ... }:
let
  tokenSecret = ./secrets/nix-access-tokens.age;
in
{
  flake.nixosModules.common-nix-access-tokens =
    { config, ... }:
    {
      config = lib.mkIf (builtins.pathExists tokenSecret) {
        age.secrets.nix-access-tokens = {
          file = tokenSecret;
          owner = "elars";
          mode = "0400";
        };

        nix.extraOptions = ''
          !include ${config.age.secrets.nix-access-tokens.path}
        '';
      };
    };
}
