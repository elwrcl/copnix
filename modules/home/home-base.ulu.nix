{ ... }:
{
  flake.homeModules.home-base =
    { ... }:
    {
      programs.home-manager.enable = true;
      fonts.fontconfig.enable = true;
    };
}
