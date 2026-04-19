{ pkgs, lib, ... }:

{
  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.niri = lib.mkForce {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
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
