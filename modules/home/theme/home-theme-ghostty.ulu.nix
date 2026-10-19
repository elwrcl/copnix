{ ... }:
{
  flake.homeModules.home-theme-ghostty =
    { config, lib, ... }:
    let
      p = config.elars.theme.palette;

      toHex2 =
        n:
        let
          h = lib.toLower (lib.toHexString n);
        in
        if n < 16 then "0${h}" else h;

      clamp = n: lib.max 0 (lib.min 255 n);
      tone =
        sat: bright: hex:
        let
          rgb = config.elars.theme.hexToRgb hex;
          r = builtins.elemAt rgb 0;
          g = builtins.elemAt rgb 1;
          b = builtins.elemAt rgb 2;
          y = (299 * r + 587 * g + 114 * b) / 1000;
          ch = c: clamp ((y * 100 + (c - y) * sat) / 100 * bright / 100);
        in
        "#${toHex2 (ch r)}${toHex2 (ch g)}${toHex2 (ch b)}";

      surface = tone 100 80;
      dim = tone 100 95;
      text = tone 100 92;
      hue = tone 60 88;
    in
    {
      programs.ghostty.settings = {
        background = surface p.base00;
        foreground = text p.base05;
        cursor-color = hue p.accent;
        cursor-text = surface p.base00;
        selection-background = surface p.base02;
        selection-foreground = text p.base05;
        palette = [
          "0=${surface p.base00}"
          "1=${hue p.base08}"
          "2=${hue p.base0B}"
          "3=${hue p.base0A}"
          "4=${hue p.base0D}"
          "5=${hue p.base0E}"
          "6=${hue p.base0C}"
          "7=${text p.base05}"
          "8=${dim p.base03}"
          "9=${hue p.base08}"
          "10=${hue p.base0B}"
          "11=${hue p.base09}"
          "12=${hue p.base0D}"
          "13=${hue p.base0E}"
          "14=${hue p.base0C}"
          "15=${text p.base07}"
        ];
      };
    };
}
