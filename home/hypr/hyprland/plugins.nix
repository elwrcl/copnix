{ inputs, pkgs, ... }:

let
  hyprspace = inputs.hyprspace.packages.${pkgs.system}.Hyprspace.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      sed -i '/#include <hyprland\/src\/config\/ConfigManager.hpp>/a #include <hyprland/src/config/legacy/ConfigManager.hpp>' src/Globals.hpp
      sed -i '/#include <hyprland\/src\/config\/legacy\/ConfigManager.hpp>/a #include <hyprland/src/config/shared/animation/AnimationTree.hpp>' src/Globals.hpp
      sed -i '/#include <hyprland\/src\/config\/shared\/animation\/AnimationTree.hpp>/a #include <hyprland/src/config/ConfigValue.hpp>' src/Globals.hpp

      substituteInPlace src/Globals.hpp \
        --replace-fail 'eRenderPassMode' 'Render::eRenderPassMode'

      substituteInPlace src/Layout.cpp \
        --replace-fail 'CCssGapData' 'Config::CCssGapData' \
        --replace-fail 'g_pConfigManager->handleWorkspaceRules' 'Config::Legacy::mgr()->handleWorkspaceRules'

      substituteInPlace src/Overview.cpp \
        --replace-fail 'g_pConfigManager->getAnimationPropertyConfig' 'Config::animationTree()->getAnimationPropertyConfig'

      substituteInPlace src/Render.cpp \
        --replace-fail 'SRenderModifData' 'Render::SRenderModifData' \
        --replace-fail 'g_pHyprOpenGL->m_renderData' 'g_pHyprRenderer->m_renderData' \
        --replace-fail 'RENDER_PASS_ALL' 'Render::RENDER_PASS_ALL' \
        --replace-fail 'g_pHyprRenderer->m_renderData.pCurrentMonData->blurFBShouldRender = true;' '// blur API changed in Hyprland 0.54'

      substituteInPlace src/main.cpp \
        --replace-fail 'g_pHyprOpenGL->m_renderData' 'g_pHyprRenderer->m_renderData' \
        --replace-fail 'RENDER_PASS_MAIN' 'Render::RENDER_PASS_MAIN'

      sed -i '/^void renderBorder(CBox box, CGradientValueData gradient, int size) {/,/^}/c\
void renderBorder(CBox box, CHyprColor color, int size) {\
    if (size <= 0 || color.a <= 0.F)\
        return;\
\
    renderRect({box.x, box.y, box.w, size}, color);\
    renderRect({box.x, box.y + box.h - size, box.w, size}, color);\
    renderRect({box.x, box.y, size, box.h}, color);\
    renderRect({box.x + box.w - size, box.y, size, box.h}, color);\
}' src/Render.cpp

      substituteInPlace src/Render.cpp \
        --replace-fail 'renderBorder(curWorkspaceBox, CGradientValueData(Config::workspaceActiveBorder), Config::workspaceBorderSize);' 'renderBorder(curWorkspaceBox, Config::workspaceActiveBorder, Config::workspaceBorderSize);' \
        --replace-fail 'renderBorder(curWorkspaceBox, CGradientValueData(Config::workspaceInactiveBorder), Config::workspaceBorderSize);' 'renderBorder(curWorkspaceBox, Config::workspaceInactiveBorder, Config::workspaceBorderSize);'
    '';
  });
in
{
  wayland.windowManager.hyprland = {
    plugins = [ hyprspace ];

    settings = {
      bind = [
        "$mainMod, TAB, exec, hyprctl dispatch overview:toggle"
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
