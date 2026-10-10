{ ... }:
{
  flake.homeModules.home-theme-stylus =
    { config, ... }:
    let
      p = config.elars.theme.palette.withHashtag;
      accent = p.accent or p.base06;
    in
    {
      xdg.configFile."stylus/kemuri.user.css".text = ''
        /* ==UserStyle==
        @name         Kemuri (square)
        @namespace    copland
        @version      1.0.0
        @description  Square corners, no shadows, kemuri palette. Generated from elars.theme.palette.
        @author       elars
        ==/UserStyle== */

        @-moz-document regexp(".*") {
          * {
            border-radius: 0px !important;
            box-shadow: none !important;

            --dt-black: ${p.base00};
            --dt-gray-0: ${p.base00};
            --dt-gray-1: ${p.base01};
            --dt-gray-2: ${p.base02};
            --dt-gray-3: ${p.base03};
            --dt-gray-4: ${p.base0F};
            --dt-gray-5: ${p.base04};
            --dt-gray-6: ${p.base04};
            --dt-gray-7: ${p.base06};
            --dt-gray-8: ${p.base06};
            --dt-gray-9: ${p.base05};
            --dt-gray-10: ${p.base05};
            --dt-white: ${p.base07};
            --dt-red-6: ${p.base08};
            --dt-red-7: ${p.base08};
            --dt-orange-6: ${p.base09};
            --dt-orange-7: ${p.base09};
            --dt-yellow: ${p.base0A};
            --dt-green-6: ${p.base0B};
            --dt-green-7: ${p.base0B};
            --dt-cyan-6: ${p.base0C};
            --dt-cyan-7: ${p.base0C};
            --dt-blue-6: ${p.base0D};
            --dt-blue-7: ${p.base0D};
            --dt-blue-8: ${p.base0D};
            --dt-magenta-7: ${p.base0E};
            --dt-magenta-8: ${p.base0E};
          }

          html {
            accent-color: ${accent};
            caret-color: ${accent};
            scrollbar-color: ${p.base03} transparent;
          }

          ::selection {
            background: ${accent};
            color: ${p.base00};
          }
        }
      '';
    };
}
