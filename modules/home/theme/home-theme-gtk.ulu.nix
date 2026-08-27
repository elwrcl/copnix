{ ... }:
{
  flake.homeModules.home-theme-gtk =
    { config, pkgs, ... }:
    {
      gtk = {
        enable = true;
        theme.name = "Adwaita-dark";
        theme.package = pkgs.gnome-themes-extra;
        gtk4.theme.name = "adwaita-dark";
        font = {
          name = "JetBrainsMono Nerd Font";
          size = 11;
        };

        gtk3.extraCss = config.elars.theme.palette.adwaitaGtkCss;
        gtk4.extraCss = config.elars.theme.palette.adwaitaGtkCss;
      };

      dconf.settings."org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-application-prefer-dark-theme = true;
        gtk-theme = "Adwaita-dark";
      };
    };
}
