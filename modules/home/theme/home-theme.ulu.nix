{ ... }:
{
  flake.homeModules.home-theme =
    { lib, ... }:
    let
      inherit (builtins) substring;

      hexDigit =
        c:
        {
          "0" = 0;
          "1" = 1;
          "2" = 2;
          "3" = 3;
          "4" = 4;
          "5" = 5;
          "6" = 6;
          "7" = 7;
          "8" = 8;
          "9" = 9;
          "a" = 10;
          "b" = 11;
          "c" = 12;
          "d" = 13;
          "e" = 14;
          "f" = 15;
        }
        .${lib.toLower c};

      hexPair = s: 16 * hexDigit (substring 0 1 s) + hexDigit (substring 1 1 s);
    in
    {
      options.elars.theme.palette = lib.mkOption {
        type = lib.types.raw;
        description = ''
          Active ThemeNix-shaped base16 palette. Set by exactly one
          `home-theme-*` module (e.g. home-theme-kemuri); consumed by
          every `home-theme-<app>` module.
        '';
      };

      options.elars.theme.hexToRgb = lib.mkOption {
        type = lib.types.raw;
        default =
          hex:
          let
            h = lib.removePrefix "#" hex;
          in
          [
            (hexPair (substring 0 2 h))
            (hexPair (substring 2 2 h))
            (hexPair (substring 4 2 h))
          ];
        description = ''
          `"1e1d1b"` (or `"#1e1d1b"`) -> `[ 30 29 27 ]`. For consumers that
          want decimal channels instead of hex (KDE's kdeglobals, zellij).
        '';
      };
    };
}
