{ ... }:

{
  programs.niri.settings = {
    environment = {
      DISPLAY = ":0";
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
      QT_STYLE_OVERRIDE = "adwaita-dark";
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_QPA_PLATFORMTHEME = "gtk3";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      TERMINAL = "ghostty";
      MESA_GL_VERSION_OVERRIDE = "4.6";
      MESA_GLSL_VERSION_OVERRIDE = "460";
    };
  };
}
