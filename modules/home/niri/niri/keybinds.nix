{ ... }:

{
  programs.niri.settings = {
    binds = {
      # --- Workspace Navigation ---
      "Ctrl+Mod+Right".action.focus-column-right = [ ];
      "Ctrl+Mod+Left".action.focus-column-left = [ ];
      "Ctrl+Mod+Down".action.focus-workspace-down = [ ];
      "Ctrl+Mod+Up".action.focus-workspace-up = [ ];
      "Ctrl+Mod+Shift+Right".action.move-column-right = [ ];
      "Ctrl+Mod+Shift+Left".action.move-column-left = [ ];
      "Ctrl+Mod+Shift+Down".action.move-window-to-workspace-down = [ ];
      "Ctrl+Mod+Shift+Up".action.move-window-to-workspace-up = [ ];

      "Ctrl+Mod+WheelScrollUp" = {
        "cooldown-ms" = 150;
        action.focus-column-right = [ ];
      };
      "Ctrl+Mod+WheelScrollDown" = {
        "cooldown-ms" = 150;
        action.focus-column-left = [ ];
      };

      # --- Interface ---
      "Mod+Space".action.spawn-sh = "noctalia msg panel-toggle launcher";
      "Mod+P".action.spawn-sh = "noctalia msg panel-toggle control-center";
      "Mod+Tab".action.toggle-overview = [ ];
      "Ctrl+Alt+Delete".action.spawn-sh = "noctalia msg settings-toggle";

      # --- Launchers ---
      "Mod+Return".action.spawn = [ "ghostty" ];
      "Mod+W".action.spawn = [ "zen-beta" ];
      "Mod+E".action.spawn = [ "dolphin" ];
      "Mod+Z".action.spawn = [ "code" ];
      "Mod+Alt+V".action.spawn = [ "pavucontrol" ];
      "Mod+Shift+V".action.spawn-sh = "noctalia msg panel-toggle clipboard";
      "Mod+Shift+L".action.spawn-sh = "noctalia msg lock";
      "Ctrl+Shift+Escape".action.spawn = [
        "ghostty"
        "-e"
        "sudo"
        "btop"
      ];

      # --- Window Management ---
      "Mod+Q".action.close-window = [ ];
      "Mod+Alt+Space".action.toggle-window-floating = [ ];
      "Mod+F".action.fullscreen-window = [ ];
      "Mod+D".action.maximize-column = [ ];

      # --- Focus ---
      "Mod+Left".action.focus-column-left = [ ];
      "Mod+Right".action.focus-column-right = [ ];
      "Mod+Up".action.focus-window-up = [ ];
      "Mod+Down".action.focus-window-down = [ ];

      # --- Move Windows ---
      "Mod+Shift+Left".action.move-column-left = [ ];
      "Mod+Shift+Right".action.move-column-right = [ ];
      "Mod+Shift+Up".action.move-window-up = [ ];
      "Mod+Shift+Down".action.move-window-down = [ ];

      # --- Workspaces by Number ---
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+0".action.focus-workspace = 10;

      "Mod+Shift+1".action.move-window-to-workspace = 1;
      "Mod+Shift+2".action.move-window-to-workspace = 2;
      "Mod+Shift+3".action.move-window-to-workspace = 3;
      "Mod+Shift+4".action.move-window-to-workspace = 4;
      "Mod+Shift+5".action.move-window-to-workspace = 5;
      "Mod+Shift+6".action.move-window-to-workspace = 6;
      "Mod+Shift+7".action.move-window-to-workspace = 7;
      "Mod+Shift+8".action.move-window-to-workspace = 8;
      "Mod+Shift+9".action.move-window-to-workspace = 9;
      "Mod+Shift+0".action.move-window-to-workspace = 10;

      # --- Mouse Workspace Scroll ---
      "Mod+WheelScrollDown" = {
        "cooldown-ms" = 150;
        action.focus-workspace-down = [ ];
      };
      "Mod+WheelScrollUp" = {
        "cooldown-ms" = 150;
        action.focus-workspace-up = [ ];
      };

      # --- Media & Hardware Keys ---
      "Mod+Shift+N".action.spawn = [
        "playerctl"
        "next"
      ];
      "Mod+Shift+B".action.spawn = [
        "playerctl"
        "previous"
      ];
      "Mod+Shift+P".action.spawn = [
        "playerctl"
        "play-pause"
      ];

      "XF86AudioRaiseVolume" = {
        "allow-when-locked" = true;
        action.spawn-sh = "noctalia msg volume-up";
      };
      "XF86AudioLowerVolume" = {
        "allow-when-locked" = true;
        action.spawn-sh = "noctalia msg volume-down";
      };
      "XF86AudioMute" = {
        "allow-when-locked" = true;
        action.spawn-sh = "noctalia msg volume-mute";
      };
      "XF86AudioMicMute" = {
        "allow-when-locked" = true;
        action.spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_SOURCE@"
          "toggle"
        ];
      };
      "XF86MonBrightnessUp".action.spawn-sh = "noctalia msg brightness-up";
      "XF86MonBrightnessDown".action.spawn-sh = "noctalia msg brightness-down";
      "XF86AudioNext" = {
        "allow-when-locked" = true;
        action.spawn = [
          "playerctl"
          "next"
        ];
      };
      "XF86AudioPrev" = {
        "allow-when-locked" = true;
        action.spawn = [
          "playerctl"
          "previous"
        ];
      };
      "XF86AudioPlay" = {
        "allow-when-locked" = true;
        action.spawn = [
          "playerctl"
          "play-pause"
        ];
      };
      "XF86AudioPause" = {
        "allow-when-locked" = true;
        action.spawn = [
          "playerctl"
          "play-pause"
        ];
      };
    };
  };
}
