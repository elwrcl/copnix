{ ... }:

let
  ipc = "noctalia-shell ipc call";
in
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    bindr = [
      { _args = [ "$mainMod" "SUPER_L" "exec" "${ipc} launcher toggle" ]; }
    ];

    bind = [
      # workspace
      { _args = [ "CTRL $mainMod" "right" "layoutmsg" "focus r" ]; }
      { _args = [ "CTRL $mainMod" "left" "layoutmsg" "focus l" ]; }
      { _args = [ "CTRL $mainMod" "down" "workspace" "r+1" ]; }
      { _args = [ "CTRL $mainMod" "up" "workspace" "r-1" ]; }
      { _args = [ "CTRL $mainMod SHIFT" "right" "layoutmsg" "movewindowto r" ]; }
      { _args = [ "CTRL $mainMod SHIFT" "left" "layoutmsg" "movewindowto l" ]; }
      { _args = [ "CTRL $mainMod SHIFT" "down" "movetoworkspace" "r+1" ]; }
      { _args = [ "CTRL $mainMod SHIFT" "up" "movetoworkspace" "r-1" ]; }
      { _args = [ "$mainMod" "R" "layoutmsg" "colresize +conf" ]; }
      { _args = [ "$mainMod" "C" "layoutmsg" "center" ]; }
      { _args = [ "$mainMod SHIFT" "R" "layoutmsg" "colresize 0.7" ]; }

      # interface
      { _args = [ "$mainMod" "P" "exec" "${ipc} bar toggle" ]; }
      { _args = [ "CTRL ALT" "Delete" "exec" "${ipc} sessionMenu toggle" ]; }
      # plugins
      { _args = [ "$mainMod SHIFT" "S" "exec" "${ipc} plugin:screen-shot-and-record screenshot" ]; }
      { _args = [ "$mainMod SHIFT" "Z" "exec" "${ipc} plugin:screen-shot-and-record search" ]; }
      { _args = [ "$mainMod SHIFT" "X" "exec" "${ipc} plugin:screen-shot-and-record ocr" ]; }
      { _args = [ "$mainMod SHIFT" "C" "exec" "${ipc} plugin:music panel" ]; }
      # launchers
      { _args = [ "$mainMod" "Return" "exec" "ghostty" ]; }
      { _args = [ "$mainMod" "W" "exec" "zen-beta" ]; }
      { _args = [ "$mainMod" "E" "exec" "nautilus" ]; }
      { _args = [ "$mainMod" "Z" "exec" "zeditor" ]; }
      { _args = [ "$mainMod ALT" "V" "exec" "pavucontrol" ]; }
      { _args = [ "$mainMod SHIFT" "V" "exec" "${ipc} launcher clipboard" ]; }
      { _args = [ "$mainMod SHIFT" "L" "exec" "${ipc} lockScreen lock" ]; }
      { _args = [ "CTRL SHIFT" "Escape" "exec" "ghostty -e btop" ]; }

      # window management
      { _args = [ "$mainMod" "Q" "killactive" ]; }
      { _args = [ "$mainMod ALT" "SPACE" "togglefloating" ]; }
      { _args = [ "$mainMod" "F" "fullscreen" "0" ]; }
      { _args = [ "$mainMod" "D" "fullscreen" "1" ]; }
      { _args = [ "$mainMod ALT" "P" "pin" ]; }

      # focus windows
      { _args = [ "$mainMod" "left" "layoutmsg" "move -col" ]; }
      { _args = [ "$mainMod" "right" "layoutmsg" "move +col" ]; }
      { _args = [ "$mainMod" "up" "movefocus" "u" ]; }
      { _args = [ "$mainMod" "down" "movefocus" "d" ]; }

      { _args = [ "$mainMod SHIFT" "left" "layoutmsg" "movewindowto l" ]; }
      { _args = [ "$mainMod SHIFT" "right" "layoutmsg" "movewindowto r" ]; }
      { _args = [ "$mainMod SHIFT" "up" "movewindow" "u" ]; }
      { _args = [ "$mainMod SHIFT" "down" "movewindow" "d" ]; }

      # workspace navigation
      { _args = [ "$mainMod" "1" "workspace" "1" ]; }
      { _args = [ "$mainMod" "2" "workspace" "2" ]; }
      { _args = [ "$mainMod" "3" "workspace" "3" ]; }
      { _args = [ "$mainMod" "4" "workspace" "4" ]; }
      { _args = [ "$mainMod" "5" "workspace" "5" ]; }
      { _args = [ "$mainMod" "6" "workspace" "6" ]; }
      { _args = [ "$mainMod" "7" "workspace" "7" ]; }
      { _args = [ "$mainMod" "8" "workspace" "8" ]; }
      { _args = [ "$mainMod" "9" "workspace" "9" ]; }
      { _args = [ "$mainMod" "0" "workspace" "10" ]; }

      # move windows to workspace
      { _args = [ "$mainMod SHIFT" "1" "movetoworkspace" "1" ]; }
      { _args = [ "$mainMod SHIFT" "2" "movetoworkspace" "2" ]; }
      { _args = [ "$mainMod SHIFT" "3" "movetoworkspace" "3" ]; }
      { _args = [ "$mainMod SHIFT" "4" "movetoworkspace" "4" ]; }
      { _args = [ "$mainMod SHIFT" "5" "movetoworkspace" "5" ]; }
      { _args = [ "$mainMod SHIFT" "6" "movetoworkspace" "6" ]; }
      { _args = [ "$mainMod SHIFT" "7" "movetoworkspace" "7" ]; }
      { _args = [ "$mainMod SHIFT" "8" "movetoworkspace" "8" ]; }
      { _args = [ "$mainMod SHIFT" "9" "movetoworkspace" "9" ]; }
      { _args = [ "$mainMod SHIFT" "0" "movetoworkspace" "10" ]; }

      # special workspaces
      { _args = [ "$mainMod" "S" "togglespecialworkspace" ]; }
      { _args = [ "$mainMod ALT" "S" "movetoworkspacesilent" "special" ]; }

      #  mouse workspace navigation
      { _args = [ "$mainMod" "mouse_up" "workspace" "+1" ]; }
      { _args = [ "$mainMod" "mouse_down" "workspace" "-1" ]; }

      # media keys
      { _args = [ "$mainMod SHIFT" "N" "exec" "playerctl next" ]; }
      { _args = [ "$mainMod SHIFT" "B" "exec" "playerctl previous" ]; }
      { _args = [ "$mainMod SHIFT" "P" "exec" "playerctl play-pause" ]; }
    ];

    # mouse binds
    bindm = [
      { _args = [ "$mainMod" "mouse:272" "movewindow" ]; }
      { _args = [ "$mainMod" "mouse:273" "resizewindow" ]; }
    ];

    # volume and brightness binds
    bindel = [
      { _args = [ "" "XF86AudioRaiseVolume" "exec" "${ipc} volume increase" ]; }
      { _args = [ "" "XF86AudioLowerVolume" "exec" "${ipc} volume decrease" ]; }
      { _args = [ "" "XF86MonBrightnessUp" "exec" "${ipc} brightness increase" ]; }
      { _args = [ "" "XF86MonBrightnessDown" "exec" "${ipc} brightness decrease" ]; }
    ];

    # volume and media keys
    bindl = [
      { _args = [ "" "XF86AudioMute" "exec" "${ipc} volume muteOutput" ]; }
      { _args = [ "" "XF86AudioMicMute" "exec" "wpctl set-mute @DEFAULT_SOURCE@ toggle" ]; }
      { _args = [ "" "XF86AudioNext" "exec" "playerctl next" ]; }
      { _args = [ "" "XF86AudioPrev" "exec" "playerctl previous" ]; }
      { _args = [ "" "XF86AudioPlay" "exec" "playerctl play-pause" ]; }
      { _args = [ "" "XF86AudioPause" "exec" "playerctl play-pause" ]; }
    ];
  };
}
