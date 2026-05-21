{
  pkgs,
  inputs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [
      "hyprland"
      "gtk"
    ];
  };

  services = {
    dbus.enable = true;
  };

  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [
    glib
    dconf
    dconf-editor
    xdg-utils
    xdg-user-dirs
  ];
}
