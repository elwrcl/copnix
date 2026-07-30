{ ... }:
{
  flake.homeModules.home-gtk =
    { pkgs, ... }:
    {
      gtk = {
        enable = true;
        theme.name = "WhiteSur-Dark";
        theme.package = pkgs.whitesur-gtk-theme;
        gtk4.theme.name = "WhiteSur-Dark";
        gtk4.theme.package = pkgs.whitesur-gtk-theme;
        iconTheme.name = "WhiteSur-dark";
        iconTheme.package = pkgs.whitesur-icon-theme;
        font = {
          name = "JetBrainsMono Nerd Font";
          size = 11;
        };
      };

      dconf.settings."org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-application-prefer-dark-theme = true;
        gtk-theme = "WhiteSur-Dark";
      };
    };
}
