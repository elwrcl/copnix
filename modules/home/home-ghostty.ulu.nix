{ ... }:
{
  flake.homeModules.home-ghostty =
    { pkgs, lib, ... }:
    let
      isDarwin = pkgs.stdenv.isDarwin;

      linuxKeybinds = [
        "alt+r=reload_config"

        "ctrl+shift+q=close_surface"

        "ctrl+shift+t=new_tab"
        "ctrl+shift+page_down=next_tab"
        "ctrl+shift+page_up=previous_tab"
        "ctrl+shift+comma=move_tab:-1"
        "ctrl+shift+period=move_tab:1"

        "ctrl+shift+1=goto_tab:1"
        "ctrl+shift+2=goto_tab:2"
        "ctrl+shift+3=goto_tab:3"
        "ctrl+shift+4=goto_tab:4"
        "ctrl+shift+5=goto_tab:5"
        "ctrl+shift+6=goto_tab:6"
        "ctrl+shift+7=goto_tab:7"
        "ctrl+shift+8=goto_tab:8"
        "ctrl+shift+9=goto_tab:9"

        "ctrl+shift+backslash=new_split:right"
        "ctrl+shift+minus=new_split:down"

        "ctrl+shift+h=goto_split:left"
        "ctrl+shift+j=goto_split:bottom"
        "ctrl+shift+k=goto_split:top"
        "ctrl+shift+l=goto_split:right"

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
          font-size = 12;

          window-padding-x = 10;
          window-padding-y = 10;
          window-padding-balance = true;
          window-save-state = "always";

          mouse-hide-while-typing = true;
          mouse-scroll-multiplier = 2;
          shell-integration-features = "no-cursor,sudo,no-title";

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
    };
}
