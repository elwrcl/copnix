{ ... }:
{
  flake.homeModules.home-direnv =
    { ... }:
    {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableNushellIntegration = true;
      };
    };
}
