{ pkgs, lib, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.hyprland = lib.mkForce {
      default = "gtk";
      "org.freedesktop.impl.portal.Screenshot" = "hyprland";
      "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
    };
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
