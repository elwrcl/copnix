{
  pkgs,
  inputs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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

  security.wrappers = {
    gsr-kms-server = {
      source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
      capabilities = "cap_sys_admin+ep";
      owner = "root";
      group = "root";
      permissions = "u+rx,g+rx,o+rx";
    };
  };
}
