{ ... }:
{
  # Baked into the sidechery build (see home-browser-helium-sidechery).
  flake.homeModules.home-theme-sidechery =
    { config, ... }:
    let
      # Colour variables for one palette. sidechery's sidebar follows the
      # browser's light/dark mode, so each palette goes under its own
      # prefers-color-scheme query.
      colors =
        palette:
        let
          p = palette.withHashtag;
          accent = p.accent or p.base06;
        in
        ''
          #root.root {
            --frame-bg: ${p.base00};
            --frame-fg: ${p.base05};
            --toolbar-bg: ${p.base01};
            --toolbar-fg: ${p.base05};
            --popup-bg: ${p.base01};
            --popup-fg: ${p.base05};
            --s-accent: ${accent};
            --nav-btn-active-shadow: inset 0 0 0 1px ${accent};
          }

          [data-color=red] { --color: ${p.base08}; }
          [data-color=orange] { --color: ${p.base09}; }
          [data-color=yellow] { --color: ${p.base0A}; }
          [data-color=green] { --color: ${p.base0B}; }
          [data-color=cyan],
          [data-color=turquoise] { --color: ${p.base0C}; }
          [data-color=blue] { --color: ${p.base0D}; }
          [data-color=purple] { --color: ${p.base0E}; }
          [data-color=pink] { --color: color-mix(in oklab, white 25%, ${p.base0E}); }
          [data-color=gray] { --color: ${p.base04}; }
        '';
    in
    {
      elars.sidechery.extraCss = ''
        /* generated from elars.theme.palette / paletteLight */
        @media (prefers-color-scheme: dark) {
        ${colors config.elars.theme.palette}
        }

        @media (prefers-color-scheme: light) {
        ${colors config.elars.theme.paletteLight}
        }

        #root.root {
          --nav-btn-len-margin: 2px;
          --tabs-border-radius: 0px;
        }

        .Tab[data-pin=false] .fav {
          margin: 0 var(--tabs-inner-gap) 0 var(--tabs-inner-gap);
        }

        .NavigationBar,
        .NavigationBar .nav-item {
          border-radius: 0px;
        }

        .top-horizontal-box {
          margin-bottom: 2px;
          margin-left: 2px;
        }

        .NavigationBar .nav-item .len {
          font-size: .5rem;
        }
      '';
    };
}
