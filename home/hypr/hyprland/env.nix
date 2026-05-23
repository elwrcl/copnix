{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    env = [
      { _args = [ "XCURSOR_SIZE" "24" ]; }
      { _args = [ "XCURSOR_THEME" "Bibata-Modern-Classic" ]; }
      { _args = [ "QT_STYLE_OVERRIDE" "adwaita-dark" ]; }
      { _args = [ "GDK_BACKEND" "wayland" "x11" ]; }
      { _args = [ "QT_QPA_PLATFORM" "wayland;xcb" ]; }
      { _args = [ "QT_QPA_PLATFORMTHEME" "gtk3" ]; }
      { _args = [ "ELECTRON_OZONE_PLATFORM_HINT" "auto" ]; }
      { _args = [ "TERMINAL" "ghostty" ]; }
      { _args = [ "MESA_GL_VERSION_OVERRIDE" "4.6" ]; }
      { _args = [ "MESA_GLSL_VERSION_OVERRIDE" "460" ]; }
    ];
  };
}
