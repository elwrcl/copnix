{ pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;

  linuxKeybinds = [
    "alt+r=reload_config"
    "alt+q=close_surface"

    "ctrl+space=new_tab"
    "ctrl+page_down=next_tab"
    "ctrl+page_up=previous_tab"
    "alt+comma=move_tab:-1"
    "alt+period=move_tab:1"

    "alt+1=goto_tab:1"
    "alt+2=goto_tab:2"
    "alt+3=goto_tab:3"
    "alt+4=goto_tab:4"
    "alt+5=goto_tab:5"
    "alt+6=goto_tab:6"
    "alt+7=goto_tab:7"
    "alt+8=goto_tab:8"
    "alt+9=goto_tab:9"

    "ctrl+shift+backslash=new_split:right"
    "ctrl+shift+minus=new_split:down"

    "alt+h=goto_split:left"
    "alt+j=goto_split:bottom"
    "alt+k=goto_split:top"
    "alt+l=goto_split:right"

    "ctrl+shift+z=toggle_split_zoom"
    "ctrl+shift+e=equalize_splits"
  ];

  darwinKeybinds = [
    "cmd+s>r=reload_config"
    "cmd+s>x=close_surface"
    "cmd+s>n=new_window"

    "cmd+s>c=new_tab"
    "cmd+s>shift+l=next_tab"
    "cmd+s>shift+h=previous_tab"
    "cmd+s>comma=move_tab:-1"
    "cmd+s>period=move_tab:1"

    "cmd+s>1=goto_tab:1"
    "cmd+s>2=goto_tab:2"
    "cmd+s>3=goto_tab:3"
    "cmd+s>4=goto_tab:4"
    "cmd+s>5=goto_tab:5"
    "cmd+s>6=goto_tab:6"
    "cmd+s>7=goto_tab:7"
    "cmd+s>8=goto_tab:8"
    "cmd+s>9=goto_tab:9"

    "cmd+s>\\=new_split:right"
    "cmd+s>-=new_split:down"
    "cmd+s>h=goto_split:left"
    "cmd+s>j=goto_split:bottom"
    "cmd+s>k=goto_split:top"
    "cmd+s>l=goto_split:right"
    "cmd+s>z=toggle_split_zoom"
    "cmd+s>e=equalize_splits"
  ];
in
{
  programs.ghostty = {
    enable = true;
    installBatSyntax = true;
    enableZshIntegration = true;

    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 11;

      window-padding-x = 10;
      window-padding-y = 10;
      window-padding-balance = true;
      window-save-state = "always";

      mouse-hide-while-typing = true;
      mouse-scroll-multiplier = 2;
      shell-integration-features = "no-cursor,sudo,no-title";

      palette = [
        "0=#090E13"
        "1=#c4746e"
        "2=#8a9a7b"
        "3=#c4b28a"
        "4=#8ba4b0"
        "5=#a292a3"
        "6=#8ea4a2"
        "7=#a4a7a4"
        "8=#5C6066"
        "9=#e46876"
        "10=#87a987"
        "11=#e6c384"
        "12=#7fb4ca"
        "13=#938aa9"
        "14=#7aa89f"
        "15=#c5c9c7"
      ];

      background = "#090E13";
      foreground = "#c5c9c7";
      cursor-color = "#c5c9c7";
      cursor-text = "#9cdef2";
      selection-background = "#22262D";
      selection-foreground = "#c5c9c7";
      cursor-style = "block";
      cursor-style-blink = true;
      adjust-cell-height = "35%";
      background-opacity = 0.96;

      keybind = linuxKeybinds ++ lib.optionals isDarwin darwinKeybinds;
    }
    // lib.optionalAttrs isDarwin {
      macos-titlebar-style = "transparent";
    };
  };
}
