{ ... }:

{
  programs.niri.settings = {
    environment = {
      DISPLAY = ":0";
      XCURSOR_SIZE = "24";
      TERMINAL = "ghostty";
      XCURSOR_THEME = "macOS";
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORMTHEME = "gtk";
      QT_QPA_PLATFORM = "wayland;xcb";
      MESA_GL_VERSION_OVERRIDE = "4.6";
      MESA_GLSL_VERSION_OVERRIDE = "460";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  };
}
