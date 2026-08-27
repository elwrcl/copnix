{ ... }:
{
  flake.homeModules.home-qt =
    { config, pkgs, ... }:
    let
      p = config.elars.theme.palette.withHashtag;
      active = builtins.concatStringsSep ", " [
        p.base05 p.base01 p.base02 p.base02 p.base00 p.base01
        p.base05 p.base07 p.base05 p.base01 p.base00 p.base00
        p.base06 p.base00 p.base0D p.base0E p.base02 p.base01
        p.base01 p.base05 p.base04
      ];
      inactive = active;
      disabled = builtins.concatStringsSep ", " [
        p.base04 p.base01 p.base02 p.base02 p.base00 p.base01
        p.base04 p.base06 p.base04 p.base01 p.base00 p.base00
        p.base02 p.base04 p.base04 p.base04 p.base02 p.base01
        p.base01 p.base04 p.base03
      ];

      font = "JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0";
    in
    {
      qt = {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "qtct";
      };

      home.packages = [
        pkgs.qt5ct
        pkgs.qt6ct
      ];

      xdg.configFile."qt5ct/colors/kemuri.conf".text = ''
        [ColorScheme]
        active_colors=${active}
        inactive_colors=${inactive}
        disabled_colors=${disabled}
      '';
      xdg.configFile."qt6ct/colors/kemuri.conf".text = ''
        [ColorScheme]
        active_colors=${active}
        inactive_colors=${inactive}
        disabled_colors=${disabled}
      '';

      xdg.configFile."qt5ct/qt5ct.conf".text = ''
        [Appearance]
        style=Fusion
        custom_palette=true
        color_scheme_path=${config.xdg.configHome}/qt5ct/colors/kemuri.conf
        standard_dialogs=default

        [Fonts]
        fixed="${font}"
        general="${font}"
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
        font=${font}
        fixed=${font}
        menuFont=${font}
        toolBarFont=${font}
        smallestReadableFont=JetBrainsMono Nerd Font,9,-1,5,50,0,0,0,0,0

        [Icons]
        Theme=int_nord
      '';
    };
}
