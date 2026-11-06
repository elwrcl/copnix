{ ... }:
{
  flake.homeModules.home-ghostty =
    { ... }:
    let
      keybinds = [
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

    in
    {
      programs.ghostty = {
        enable = true;
        installBatSyntax = true;
        enableZshIntegration = true;

        settings = {
          # nerd glyphs come from ghostty's embedded symbols font
          font-family = "Obel Mono";
          font-size = 11;

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

          keybind = keybinds;
        };
      };
    };
}
