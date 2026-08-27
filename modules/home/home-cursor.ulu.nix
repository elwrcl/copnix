{ inputs, ... }:
{
  flake.homeModules.home-cursor =
    { config, pkgs, ... }:
    let
      p = config.elars.theme.palette.withHashtag;

      cursors = inputs.theme-assets.lib.mkCursorTheme {
        inherit pkgs;
        themeName = "KemuriSusu-cursors";
        light = p.base05;
        dark = p.base00;
      };
    in
    {
      home.pointerCursor = {
        enable = true;
        name = "KemuriSusu-cursors";
        package = cursors;
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };
    };
}
