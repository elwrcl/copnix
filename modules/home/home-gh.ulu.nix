{ ... }:
{
  flake.homeModules.home-gh =
    { ... }:
    {
      programs.gh = {
        enable = true;
        settings.version = 1;
      };
    };
}
