''
  binds {
    Mod+Space { spawn "noctalia-shell" "ipc" "call" "launcher" "toggle"; }

    // Workspace navigation
    Ctrl+Mod+Right { focus-workspace-down; }
    Ctrl+Mod+Left  { focus-workspace-up; }

    // Interface
    Mod+Tab         { spawn "noctalia-shell" "ipc" "call" "launcher" "windows"; }
    Mod+P           { spawn "noctalia-shell" "ipc" "call" "bar" "toggle"; }
    Ctrl+Alt+Delete { spawn "noctalia-shell" "ipc" "call" "sessionMenu" "toggle"; }

    // Plugins
    Mod+Shift+S { spawn "noctalia-shell" "ipc" "call" "plugin:screen-shot-and-record" "screenshot"; }
    Mod+Shift+Z { spawn "noctalia-shell" "ipc" "call" "plugin:screen-shot-and-record" "search"; }
    Mod+Shift+X { spawn "noctalia-shell" "ipc" "call" "plugin:screen-shot-and-record" "ocr"; }
    Mod+Shift+C { spawn "noctalia-shell" "ipc" "call" "plugin:music" "panel"; }

    // Launchers
    Mod+Return        { spawn "ghostty"; }
    Mod+W             { spawn "zen-beta"; }
    Mod+E             { spawn "nautilus"; }
    Mod+Z             { spawn "zeditor"; }
    Mod+Alt+V         { spawn "pavucontrol"; }
    Mod+Shift+V       { spawn "noctalia-shell" "ipc" "call" "launcher" "clipboard"; }
    Mod+Shift+L       { spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock"; }
    Ctrl+Shift+Escape { spawn "ghostty" "-e" "btop"; }

    // Window management
    Mod+Q { close-window; }
    Mod+F { fullscreen-window; }
    Mod+D { maximize-column; }
    // togglefloating ve pin Niri'de yok

    // Focus
    Mod+Left  { focus-column-left; }
    Mod+Right { focus-column-right; }
    Mod+Up    { focus-window-up; }
    Mod+Down  { focus-window-down; }

    // Move windows
    Mod+Shift+Left  { move-column-left; }
    Mod+Shift+Right { move-column-right; }
    Mod+Shift+Up    { move-window-up; }
    Mod+Shift+Down  { move-window-down; }

    // Workspace navigation (absolute)
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    Mod+4 { focus-workspace 4; }
    Mod+5 { focus-workspace 5; }
    Mod+6 { focus-workspace 6; }
    Mod+7 { focus-workspace 7; }
    Mod+8 { focus-workspace 8; }
    Mod+9 { focus-workspace 9; }
    Mod+0 { focus-workspace 10; }

    // Move window to workspace
    Mod+Shift+1 { move-column-to-workspace 1; }
    Mod+Shift+2 { move-column-to-workspace 2; }
    Mod+Shift+3 { move-column-to-workspace 3; }
    Mod+Shift+4 { move-column-to-workspace 4; }
    Mod+Shift+5 { move-column-to-workspace 5; }
    Mod+Shift+6 { move-column-to-workspace 6; }
    Mod+Shift+7 { move-column-to-workspace 7; }
    Mod+Shift+8 { move-column-to-workspace 8; }
    Mod+Shift+9 { move-column-to-workspace 9; }
    Mod+Shift+0 { move-column-to-workspace 10; }

    // Media
    Mod+Shift+N { spawn "playerctl" "next"; }
    Mod+Shift+B { spawn "playerctl" "previous"; }
    Mod+Shift+P { spawn "playerctl" "play-pause"; }

    // Mouse binds
    Mod+BTN_LEFT  { move-window-with-mouse; }
    Mod+BTN_RIGHT { resize-window-with-mouse; }

    // Volume & brightness
    XF86AudioRaiseVolume  allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "volume" "increase"; }
    XF86AudioLowerVolume  allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "volume" "decrease"; }
    XF86MonBrightnessUp   allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "brightness" "increase"; }
    XF86MonBrightnessDown allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "brightness" "decrease"; }

    // Media keys
    XF86AudioMute    allow-when-locked=true { spawn "noctalia-shell" "ipc" "call" "volume" "muteOutput"; }
    XF86AudioMicMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_SOURCE@" "toggle"; }
    XF86AudioNext    allow-when-locked=true { spawn "playerctl" "next"; }
    XF86AudioPrev    allow-when-locked=true { spawn "playerctl" "previous"; }
    XF86AudioPlay    allow-when-locked=true { spawn "playerctl" "play-pause"; }
    XF86AudioPause   allow-when-locked=true { spawn "playerctl" "play-pause"; }
  }
''
