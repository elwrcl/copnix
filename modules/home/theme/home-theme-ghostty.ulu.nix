{ ... }:
{
  flake.homeModules.home-theme-ghostty =
    { config, ... }:
    let
      p = config.elars.theme.palette.withHashtag;
    in
    {
      programs.ghostty.settings = {
        background = p.base00;
        foreground = p.base05;

        cursor-color = p.accent;
        cursor-text = p.base00;

        selection-background = p.base02;
        selection-foreground = p.base05;

        palette = [
          "0=${p.base00}"
          "1=${p.base08}"
          "2=${p.base0B}"
          "3=${p.base0A}"
          "4=${p.base0D}"
          "5=${p.base0E}"
          "6=${p.base0C}"
          "7=${p.base05}"
          "8=${p.base03}"
          "9=${p.base08}"
          "10=${p.base0B}"
          "11=${p.base09}"
          "12=${p.base0D}"
          "13=${p.base0E}"
          "14=${p.base0C}"
          "15=${p.base07}"
        ];
      };
    };
}
