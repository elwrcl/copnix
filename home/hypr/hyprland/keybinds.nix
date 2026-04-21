{ ... }:

let
  qs = "qs -c ii ipc call";
  qsFallback = cmd: "qs -c ii ipc call TEST_ALIVE || ${cmd}";
in
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    # global binds (ill)
    bindid = [
      "Super, SUPER_L, Toggle search, global, quickshell:searchToggleRelease"
      "Super, SUPER_R, Toggle search, global, quickshell:searchToggleRelease"
    ];

    binditn = [
      "Super, catchall, global, quickshell:searchToggleReleaseInterrupt"
    ];

    bindit = [
      ", Super_L, global, quickshell:workspaceNumber"
      ", Super_R, global, quickshell:workspaceNumber"
    ];

    bind = [
      # qs fallback
      "Super, SUPER_L, exec, ${qsFallback "fuzzel"}"
      "Super, SUPER_R, exec, ${qsFallback "fuzzel"}"
      "Ctrl, Super_L, global, quickshell:searchToggleReleaseInterrupt"
      "Ctrl, Super_R, global, quickshell:searchToggleReleaseInterrupt"

      # qs toggles
      "Super, Tab,           global, quickshell:overviewWorkspacesToggle"
      "Super, A,             global, quickshell:sidebarLeftToggle"
      "Super, N,             global, quickshell:sidebarRightToggle"
      "Super, V,             global, quickshell:overviewClipboardToggle"
      "Super, Period,        global, quickshell:overviewEmojiToggle"
      "Super, Comma,         global, quickshell:cheatsheetToggle"
      "Super, J,             global, quickshell:barToggle"
      "Super, M,             global, quickshell:mediaControlsToggle"
      "Ctrl Alt, Delete,     global, quickshell:sessionToggle"
      "Ctrl Super, T,        global, quickshell:wallpaperSelectorToggle"
      "Ctrl Super, R,        exec, killall qs quickshell; qs -c ii &"
      "Ctrl Super, P,        global, quickshell:panelFamilyCycle"

      # cb-ss-misc
      "Super, V,             exec, ${qsFallback "cliphist list | fuzzel --match-mode fzf --dmenu | cliphist decode | wl-copy"}"
      "Super, Period,        exec, ${qsFallback "fuzzel"}"
      "Super Shift, S,       global, quickshell:regionScreenshot"
      "Super Shift, S,       exec, ${qsFallback "hyprshot --freeze --clipboard-only --mode region --silent"}"
      "Super Shift, A,       global, quickshell:regionSearch"
      "Super Shift, X,       global, quickshell:regionOcr"
      "Super Shift, C,       exec, hyprpicker -a"
      ", Print,              exec, grim - | wl-copy"

      # rec
      "Super Shift, R,       global, quickshell:regionRecord"

      # loc/session
      "Super, L,             exec, loginctl lock-session"
      "Super Shift, L,       exec, systemctl suspend"

      # Apps
      "Super, Return,        exec, ghostty"
      "Super, W,             exec, zen-beta"
      "Super, E,             exec, nautilus"
      "Super, Z,             exec, zeditor"
      "Ctrl Alt, T,          exec, ghostty"
      "Super Alt, V,         exec, pavucontrol"
      "Ctrl Shift, Escape,   exec, ghostty -e btop"

      # win management
      "Super, Q,             killactive"
      "Super Alt, SPACE,     togglefloating"
      "Super, F,             fullscreen, 0"
      "Super, D,             fullscreen, 1"
      "Super, P,             pin"

      # scrolling
      "CTRL $mainMod, right, layoutmsg, focus r"
      "CTRL $mainMod, left,  layoutmsg, focus l"
      "CTRL $mainMod, down,  workspace, r+1"
      "CTRL $mainMod, up,    workspace, r-1"
      "Super, left,          movefocus, l"
      "Super, right,         movefocus, r"
      "Super, up,            movefocus, u"
      "Super, down,          movefocus, d"

      # move win
      "CTRL $mainMod SHIFT, right, layoutmsg, movewindowto r"
      "CTRL $mainMod SHIFT, left,  layoutmsg, movewindowto l"
      "CTRL $mainMod SHIFT, down,  movetoworkspace, r+1"
      "CTRL $mainMod SHIFT, up,    movetoworkspace, r-1"
      "Super Shift, left,   layoutmsg, movewindowto l"
      "Super Shift, right,  layoutmsg, movewindowto r"
      "Super Shift, up,     movewindow, u"
      "Super Shift, down,   movewindow, d"

      # scroll layout
      "$mainMod, R,         layoutmsg, colresize +conf"
      "$mainMod, C,         layoutmsg, center"
      "$mainMod SHIFT, R,   layoutmsg, colresize 0.7"

      # wspace
      "Super, code:10,  exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh workspace 1"
      "Super, code:11,  exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh workspace 2"
      "Super, code:12,  exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh workspace 3"
      "Super, code:13,  exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh workspace 4"
      "Super, code:14,  exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh workspace 5"
      "Super, code:15,  exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh workspace 6"
      "Super, code:16,  exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh workspace 7"
      "Super, code:17,  exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh workspace 8"
      "Super, code:18,  exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh workspace 9"
      "Super, code:19,  exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh workspace 10"

      "Super Alt, code:10, exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh movetoworkspacesilent 1"
      "Super Alt, code:11, exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh movetoworkspacesilent 2"
      "Super Alt, code:12, exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh movetoworkspacesilent 3"
      "Super Alt, code:13, exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh movetoworkspacesilent 4"
      "Super Alt, code:14, exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh movetoworkspacesilent 5"
      "Super Alt, code:15, exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh movetoworkspacesilent 6"
      "Super Alt, code:16, exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh movetoworkspacesilent 7"
      "Super Alt, code:17, exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh movetoworkspacesilent 8"
      "Super Alt, code:18, exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh movetoworkspacesilent 9"
      "Super Alt, code:19, exec, ~/.config/hypr/hyprland/scripts/workspace_action.sh movetoworkspacesilent 10"

      "Ctrl Super, Right,   workspace, r+1"
      "Ctrl Super, Left,    workspace, r-1"
      "Super, Page_Down,    workspace, +1"
      "Super, Page_Up,      workspace, -1"

      # special workspace
      "Super, S,            togglespecialworkspace"
      "Super Alt, S,        movetoworkspacesilent, special"

      # media
      "Super Shift, N,      exec, playerctl next"
      "Super Shift, B,      exec, playerctl previous"
      "Super Shift, P,      exec, playerctl play-pause"
    ];

    bindm = [
      "Super, mouse:272, movewindow"
      "Super, mouse:273, resizewindow"
    ];

    bindle = [
      ", XF86MonBrightnessUp,   exec, ${qs} brightness increment || brightnessctl s 5%+"
      ", XF86MonBrightnessDown, exec, ${qs} brightness decrement || brightnessctl s 5%-"
      ", XF86AudioRaiseVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.5"
      ", XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
    ];

    bindl = [
      ", XF86AudioMute,    exec, wpctl set-mute @DEFAULT_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
      ", XF86AudioNext,    exec, playerctl next"
      ", XF86AudioPrev,    exec, playerctl previous"
      ", XF86AudioPlay,    exec, playerctl play-pause"
      ", XF86AudioPause,   exec, playerctl play-pause"
    ];
  };
}
