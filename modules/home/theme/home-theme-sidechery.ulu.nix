{ ... }:
{
  # Baked into the sidechery build (see home-browser-helium-sidechery).
  flake.homeModules.home-theme-sidechery =
    { config, ... }:
    let
      p = config.elars.theme.palette.withHashtag;
      accent = p.accent or p.base06;
    in
    {
      elars.sidechery.extraCss = ''
        /* generated from elars.theme.palette */
        #root.root {
          --frame-bg: ${p.base00};
          --toolbar-bg: ${p.base01};
          --s-accent: ${accent};

          --nav-btn-active-shadow: inset 0 0 0 1px ${accent};
          --nav-btn-len-margin: 2px;
          --tabs-border-radius: 0px;
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
