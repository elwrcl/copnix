{ ... }:
{
  flake.homeModules.home-theme-qt =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      p = config.elars.theme.palette;
      h = p.withHashtag;
      rgb = hex: lib.concatMapStringsSep "," toString (config.elars.theme.hexToRgb hex);
      accent = p.accent or p.base06;
      foregrounds = {
        Normal = p.base05;
        Inactive = p.base04;
        Active = accent;
        Link = p.base0C;
        Visited = p.base0E;
        Negative = p.base08;
        Neutral = p.base0A;
        Positive = p.base0B;
      };

      colorSet =
        name:
        {
          background,
          alternate,
          normal ? foregrounds.Normal,
          inactive ? foregrounds.Inactive,
        }:
        let
          fg = foregrounds // {
            Normal = normal;
            Inactive = inactive;
          };
        in
        ''
          [Colors:${name}]
          BackgroundNormal=${rgb background}
          BackgroundAlternate=${rgb alternate}
          DecorationFocus=${rgb accent}
          DecorationHover=${rgb p.base03}
          ForegroundActive=${rgb fg.Active}
          ForegroundInactive=${rgb fg.Inactive}
          ForegroundLink=${rgb fg.Link}
          ForegroundNegative=${rgb fg.Negative}
          ForegroundNeutral=${rgb fg.Neutral}
          ForegroundNormal=${rgb fg.Normal}
          ForegroundPositive=${rgb fg.Positive}
          ForegroundVisited=${rgb fg.Visited}
        '';

      qtctColors =
        {
          text,
          window,
          base,
          alternateBase,
          button,
          buttonText,
          bright,
          shadow,
        }:
        builtins.concatStringsSep ", " [
          text # WindowText
          button # Button
          h.base03 # Light
          h.base02 # Midlight
          shadow # Dark
          h.base03 # Mid
          buttonText # Text
          bright # BrightText
          buttonText # ButtonText
          base # Base
          window # Window
          shadow # Shadow
          h.base03 # Highlight
          bright # HighlightedText
          h.base0C # Link
          h.base0E # LinkVisited
          alternateBase # AlternateBase
          h.base01 # NoRole
          h.base01 # ToolTipBase
          text # ToolTipText
          h.base04 # PlaceholderText
        ];

      active = qtctColors {
        text = h.base05;
        window = h.base01;
        base = h.base00;
        alternateBase = h.base01;
        button = h.base02;
        buttonText = h.base05;
        bright = h.base07;
        shadow = h.base00;
      };

      disabled = qtctColors {
        text = h.base04;
        window = h.base01;
        base = h.base00;
        alternateBase = h.base01;
        button = h.base01;
        buttonText = h.base04;
        bright = h.base06;
        shadow = h.base00;
      };

      font = "JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0";
    in
    {
      qt = {
        enable = true;
        platformTheme.name = "qt6ct";
      };

      home.packages = [
        pkgs.qt6Packages.qt6ct
      ];

      xdg.configFile."qt6ct/colors/kemuri.conf".text = ''
        [ColorScheme]
        active_colors=${active}
        inactive_colors=${active}
        disabled_colors=${disabled}
      '';

      xdg.configFile."qt6ct/qt6ct.conf".text = ''
        [Appearance]
        style=Fusion
        custom_palette=true
        color_scheme_path=${config.xdg.configHome}/qt6ct/colors/kemuri.conf
        standard_dialogs=default

        [Fonts]
        fixed="${font}"
        general="${font}"
      '';

      xdg.configFile."kdeglobals".text = ''
        [General]
        ColorScheme=${p.name}
        Name=${p.name}
        font=${font}
        fixed=${font}
        menuFont=${font}
        toolBarFont=${font}
        smallestReadableFont=JetBrainsMono Nerd Font,9,-1,5,50,0,0,0,0,0

        [Icons]
        Theme=int_nord

        [KDE]
        widgetStyle=Fusion
        contrast=4

        ${colorSet "Window" {
          background = p.base01;
          alternate = p.base02;
        }}
        ${colorSet "View" {
          background = p.base00;
          alternate = p.base01;
        }}
        ${colorSet "Button" {
          background = p.base02;
          alternate = p.base01;
        }}
        ${colorSet "Header" {
          background = p.base01;
          alternate = p.base02;
        }}
        ${colorSet "Header][Inactive" {
          background = p.base00;
          alternate = p.base01;
          normal = p.base04;
        }}
        ${colorSet "Tooltip" {
          background = p.base01;
          alternate = p.base02;
        }}
        ${colorSet "Complementary" {
          background = p.base00;
          alternate = p.base01;
        }}
        ${colorSet "Selection" {
          background = p.base03;
          alternate = p.base03;
          normal = p.base07;
          inactive = p.base06;
        }}

        [WM]
        activeBackground=${rgb p.base02}
        activeBlend=${rgb p.base02}
        activeForeground=${rgb p.base05}
        inactiveBackground=${rgb p.base01}
        inactiveBlend=${rgb p.base01}
        inactiveForeground=${rgb p.base04}

        [ColorEffects:Disabled]
        Color=${rgb p.base01}
        ColorAmount=0
        ColorEffect=0
        ContrastAmount=0.65
        ContrastEffect=1
        IntensityAmount=0.1
        IntensityEffect=2

        [ColorEffects:Inactive]
        ChangeSelectionColor=true
        Color=${rgb p.base02}
        ColorAmount=0.025
        ColorEffect=2
        ContrastAmount=0.1
        ContrastEffect=2
        IntensityAmount=0
        IntensityEffect=0
      '';
    };
}
