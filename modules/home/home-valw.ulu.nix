{ ... }:
{
  flake.homeModules.home-valw =
    { inputs, pkgs, ... }:
    {
      home.packages = [ inputs.valw.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    };
}
