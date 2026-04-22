{
  pkgs,
  lib,
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
    extraPortals = [ inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  services = {
    dbus.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    gnome = {
      gnome-keyring.enable = true;
      gnome-settings-daemon.enable = lib.mkDefault false;
    };
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
