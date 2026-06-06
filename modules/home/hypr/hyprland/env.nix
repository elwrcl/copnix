{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    env = [
      "XCURSOR_SIZE,24"
      "XCURSOR_THEME,Bibata-Modern-Classic"
      "QT_STYLE_OVERRIDE,adwaita-dark"
      "GDK_BACKEND,wayland,x11"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_QPA_PLATFORMTHEME,gtk3"
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      "TERMINAL,ghostty"
    ];
  };
}
