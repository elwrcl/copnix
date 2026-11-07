{ ... }:
{
  flake.homeModules.home-zed-panels =
    { ... }:
    {
      programs.zed-editor.userKeymaps = [
        {
          context = "Workspace";
          bindings = {
            "alt-s" = "project_panel::ToggleFocus";
            "alt-space" = "terminal_panel::Toggle";
            "ctrl-space" = "git_panel::ToggleFocus";
          };
        }
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
        {
          context = "Editor";
          bindings = {
            "ctrl-space" = "git_panel::ToggleFocus";
          };
        }
      ];
    };
}
