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
    xdgOpenUsePortal = true;
    # Use the KDE portal instead of GTK
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config = {
      common.default = [ "kde" ];
      hyprland = {
        default = [
          "hyprland"
          "kde"
        ];
        "org.freedesktop.impl.portal.FileChooser" = "kde";
        "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
        "org.freedesktop.impl.portal.Screenshot" = "hyprland";
        "org.freedesktop.impl.portal.OpenURI" = "kde";
      };
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
