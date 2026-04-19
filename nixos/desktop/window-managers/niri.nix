{ pkgs, lib, ... }:

{
  programs.niri.enable = true;

  xdg.portal = {
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];

    config.niri = lib.mkForce {
      default = [
        "wlr"
        "gtk"
      ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };
  environment.etc."xdg-desktop-portal/portals/wlr.portal".text = ''
    [portal]
    DBusName=org.freedesktop.impl.portal.desktop.wlr
    Interfaces=org.freedesktop.impl.portal.Screenshot;org.freedesktop.impl.portal.ScreenCast;
    UseIn=wlroots;sway;Wayfire;river;phosh;Hyprland;niri;
  '';
}
