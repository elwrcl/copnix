{ inputs, pkgs, ... }:

let
  hyprspace = inputs.hyprspace.packages.${pkgs.system}.Hyprspace.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace src/main.cpp \
        --replace-fail 'g_pHyprOpenGL->' 'Render::GL::g_pHyprOpenGL->' \
        --replace-fail 'RENDER_PASS_MAIN' 'Render::RENDER_PASS_MAIN'

      substituteInPlace src/Render.cpp \
        --replace-fail 'g_pHyprOpenGL->' 'Render::GL::g_pHyprOpenGL->' \
        --replace-fail 'RENDER_PASS_ALL' 'Render::RENDER_PASS_ALL'
    '';
  });
in
{
  wayland.windowManager.hyprland = {
    plugins = [ hyprspace ];

    settings = {
      bind = [
        "$mainMod, TAB, overview:toggle"
      ];

      plugin = {
        overview = {
          workspaceActiveBorder = "rgba(ffffffff)";
          workspaceInactiveBorder = "rgba(ffffff66)";
          workspaceBorderSize = 2;
          workspaceActiveBackground = "rgba(ffffff18)";
          workspaceInactiveBackground = "rgba(00000066)";
          panelBorderColor = "rgba(ffffffff)";
          panelBorderWidth = 2;
          panelHeight = 240;
          workspaceMargin = 14;
          overrideAnimSpeed = 0.9;
          autoDrag = true;
          autoScroll = true;
          centerAligned = true;
          exitOnClick = true;
        };
      };
    };
  };
}
