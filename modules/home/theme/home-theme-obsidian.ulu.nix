{ ... }:
{
  flake.homeModules.home-theme-obsidian =
    { config, ... }:
    let
      p = config.elars.theme.palette.withHashtag;
      accent = p.accent or p.base06;
    in
    {
      programs.obsidian.defaultSettings = {
        appearance = {
          theme = "obsidian";
          accentColor = accent;
          baseFontSize = 15;
          monospaceFontFamily = "JetBrainsMono Nerd Font Mono";
          enabledCssSnippets = [ "kemuri" ];
        };
        cssSnippets = [
          {
            name = "kemuri";
            text = ''
              /* generated from elars.theme.palette */
              .theme-dark {
                --background-primary: ${p.base00};
                --background-primary-alt: ${p.base01};
                --background-secondary: ${p.base01};
                --background-secondary-alt: ${p.base02};
                --background-modifier-border: ${p.base02};
                --background-modifier-hover: ${p.base02};
                --text-normal: ${p.base05};
                --text-muted: ${p.base04};
                --text-faint: ${p.base03};
                --text-accent: ${accent};
                --text-on-accent: ${p.base00};
                --interactive-accent: ${accent};
                --text-selection: ${p.base02};
                --color-red: ${p.base08};
                --color-orange: ${p.base09};
                --color-yellow: ${p.base0A};
                --color-green: ${p.base0B};
                --color-cyan: ${p.base0C};
                --color-blue: ${p.base0D};
                --color-purple: ${p.base0E};
              }

              body {
                --radius-s: 0px;
                --radius-m: 0px;
                --radius-l: 0px;
                --radius-xl: 0px;
                --input-radius: 0px;
                --button-radius: 0px;
                --checkbox-radius: 0px;
                --tab-radius: 0px;
                --shadow-s: none;
                --shadow-l: none;
              }
            '';
          }
        ];
      };
    };
}
