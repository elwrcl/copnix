{ ... }:
{
  flake.nixosModules.common-spotifast =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        (pkgs.spotifast.overrideAttrs (old: rec {
          version = "0.14.2";
          src = pkgs.fetchFromGitHub {
            owner = "crmne";
            repo = "spotifast";
            tag = "v${version}";
            hash = "sha256-LdhBPj7ZrXXMvQpM/DqYH5m7zH7duTZ/tZbHO3XI5CQ=";
          };
          cargoHash = "sha256-q6wmUeh102dRN4yIwPogq726Zx4AcefUT4lDiqhSnMU=";
        }))
      ];
    };
}
