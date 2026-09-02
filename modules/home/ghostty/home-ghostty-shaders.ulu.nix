{ ... }:
{
  flake.homeModules.home-ghostty-shaders =
    { config, pkgs, ... }:
    let
      preamble = pkgs.writeText "ghostty-shader-preamble.glsl" ''
        #version 330 core
        #define CURSORSTYLE_BLOCK 0
        #define CURSORSTYLE_BLOCK_HOLLOW 1
        #define CURSORSTYLE_BAR 2
        #define CURSORSTYLE_UNDERLINE 3
        #define CURSORSTYLE_LOCK 4
        uniform vec3 iResolution;
        uniform float iTime;
        uniform float iTimeDelta;
        uniform float iFrameRate;
        uniform int iFrame;
        uniform float iChannelTime[4];
        uniform vec3 iChannelResolution[4];
        uniform vec4 iMouse;
        uniform vec4 iDate;
        uniform float iSampleRate;
        uniform sampler2D iChannel0;
        uniform vec4 iCurrentCursor;
        uniform vec4 iPreviousCursor;
        uniform vec4 iCurrentCursorColor;
        uniform vec4 iPreviousCursorColor;
        uniform vec4 iCurrentCursorStyle;
        uniform vec4 iPreviousCursorStyle;
        uniform vec4 iCursorVisible;
        uniform float iTimeCursorChange;
        uniform float iTimeFocus;
        uniform int iFocus;
        uniform vec3 iPalette[256];
        uniform vec3 iBackgroundColor;
        uniform vec3 iForegroundColor;
        uniform vec3 iCursorColor;
        uniform vec3 iCursorText;
        uniform vec3 iSelectionBackgroundColor;
        uniform vec3 iSelectionForegroundColor;
        out vec4 _ghosttyFragColor;
        #line 1
      '';

      entryPoint = pkgs.writeText "ghostty-shader-entry.glsl" ''
        void main() { mainImage(_ghosttyFragColor, gl_FragCoord.xy); }
      '';

      compiled =
        name: src:
        pkgs.runCommandLocal "ghostty-shader-${name}.glsl"
          {
            nativeBuildInputs = [ pkgs.glslang ];
          }
          ''
            cat ${preamble} ${src} ${entryPoint} > wrapped.frag
            glslangValidator -S frag wrapped.frag
            cp ${src} $out
          '';

      shaderDir = "${config.xdg.configHome}/ghostty/shaders";
    in
    {
      xdg.configFile."ghostty/shaders/cursor-smear.glsl".source =
        compiled "cursor-smear" ./cursor-smear.glsl;
      xdg.configFile."ghostty/shaders/degauss.glsl".source = compiled "degauss" ./degauss.glsl;

      programs.ghostty.settings = {
        custom-shader = [
          "${shaderDir}/cursor-smear.glsl"
          "${shaderDir}/degauss.glsl"
        ];
        custom-shader-animation = true;
      };
    };
}
