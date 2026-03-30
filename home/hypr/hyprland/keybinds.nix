{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    bindr = [
      "$mainMod, SUPER_L, exec, pkill fuzzel || fuzzel"
    ];

    bind = [
      # launchers
      "$mainMod, Return, exec, kitty"
      "$mainMod, W, exec, zen"
      "$mainMod, C, exec, zed"
      "$mainMod, E, exec, dolphin"
      "$mainMod, R, exec, pkill fuzzel || fuzzel"

      # window management
      "$mainMod, Q, killactive"
      "$mainMod ALT, SPACE, togglefloating"
      "$mainMod, F, fullscreen, 0"
      "$mainMod, D, fullscreen, 1"
      "$mainMod, P, pin"

      # lock
      "$mainMod, L, exec, loginctl lock-session"
      "$mainMod SHIFT, L, exec, systemctl suspend"

      # focus
      "$mainMod, left,  movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up,    movefocus, u"
      "$mainMod, down,  movefocus, d"

      # windows drag
      "$mainMod SHIFT, left,  movewindow, l"
      "$mainMod SHIFT, right, movewindow, r"
      "$mainMod SHIFT, up,    movewindow, u"
      "$mainMod SHIFT, down,  movewindow, d"

      # workspaces
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # moveworkspace
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # s-workspace
      "$mainMod, S, togglespecialworkspace"
      "$mainMod ALT, S, movetoworkspacesilent, special"

      # scrolling
      "$mainMod, mouse_up,   workspace, +1"
      "$mainMod, mouse_down, workspace, -1"

      # screenshot
      "Super, Print, exec, grim - | wl-copy"
      "Super SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
    ];

    # scaling w-mouse
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # volume
    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86MonBrightnessUp,   exec, brightnessctl -e4 -n2 set 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    # other
    bindl = [
      ", XF86AudioMute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute,     exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
      ", XF86AudioNext,  exec, playerctl next"
      ", XF86AudioPrev,  exec, playerctl previous"
      ", XF86AudioPlay,  exec, playerctl play-pause"
      ", XF86AudioPause, exec, playerctl play-pause"
    ];
  };
}
