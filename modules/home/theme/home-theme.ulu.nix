{ ... }:
{
  flake.homeModules.home-theme =
    { lib, ... }:
    {
      options.elars.theme.palette = lib.mkOption {
        type = lib.types.raw;
        description = ''
          Active ThemeNix-shaped base16 palette. Set by exactly one
          `home-theme-*` module (e.g. home-theme-kemuri); consumed by
          home-gtk and home-qt.
        '';
      };
    };
}
