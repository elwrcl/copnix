{ ... }:
{
  flake.homeModules.home-zed-panels =
    { ... }:
    {
      programs.zed-editor.userKeymaps = [
        {
          context = "Workspace";
          bindings = {
            "alt-s" = "project_panel::ToggleFocus"; # explorer
            "alt-space" = "terminal_panel::Toggle"; # terminal
            "ctrl-space" = "git_panel::ToggleFocus"; # source control
          };
        }

        # Pressed again inside the panel, the same key closes it; escape
        # returns to the buffer.
        {
          context = "ProjectPanel && not_editing";
          bindings = {
            "alt-s" = "workspace::ToggleLeftDock";
            "escape" = "workspace::ToggleLeftDock";
          };
        }
        {
          context = "GitPanel";
          bindings = {
            "ctrl-space" = "workspace::ToggleLeftDock";
          };
        }
        {
          context = "Terminal";
          bindings = {
            "alt-space" = "terminal_panel::Toggle";
          };
        }

        # ctrl-space would otherwise open completions inside the editor.
        {
          context = "Editor";
          bindings = {
            "ctrl-space" = "git_panel::ToggleFocus";
          };
        }
      ];
    };
}
