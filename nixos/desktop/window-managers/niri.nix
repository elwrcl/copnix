{ pkgs, ... }:

{
  programs.niri.enable = true;

  xdg.portal = {
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];

    config.niri = {
      default = [
        "wlr"
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };
}
