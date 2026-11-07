{ ... }:
{
  flake.homeModules.home-zed-arrows =
    { ... }:
    {
      programs.zed-editor.userKeymaps = [
        {
          context = "Editor && (vim_mode == helix_normal || vim_mode == helix_select) && !menu";
          bindings = {
            # goto mode — g h / g l
            "g left" = "vim::StartOfLine";
            "g right" = "vim::EndOfLine";

            # window mode — space w h/j/k/l, swap = helix's H/J/K/L
            "space w left" = "workspace::ActivatePaneLeft";
            "space w down" = "workspace::ActivatePaneDown";
            "space w up" = "workspace::ActivatePaneUp";
            "space w right" = "workspace::ActivatePaneRight";
            "space w shift-left" = "workspace::SwapPaneLeft";
            "space w shift-down" = "workspace::SwapPaneDown";
            "space w shift-up" = "workspace::SwapPaneUp";
            "space w shift-right" = "workspace::SwapPaneRight";

            # tabs — shift-h / shift-l (shift-arrows stay selection)
            "alt-left" = "pane::ActivatePreviousItem";
            "alt-right" = "pane::ActivateNextItem";
          };
        }
      ];
    };
}
