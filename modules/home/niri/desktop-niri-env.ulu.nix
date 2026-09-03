{ ... }:
{
  flake.homeModules.desktop-niri-env =
    { ... }:
    {
      programs.niri.settings = {
        environment = {
          DISPLAY = ":0";
          TERMINAL = "ghostty";
          GDK_BACKEND = "wayland,x11";
          QT_QPA_PLATFORM = "wayland;xcb";
          # HD 4000 caps at GL 4.2; ghostty and friends ask for more.
          MESA_GL_VERSION_OVERRIDE = "4.6";
          MESA_GLSL_VERSION_OVERRIDE = "460";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          # XCURSOR_* comes from home.pointerCursor (home-cursor).
          # QT_QPA_PLATFORMTHEME comes from qt.platformTheme (home-theme-qt).
        };
      };
    };
}
