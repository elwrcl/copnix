{ ... }:
{
  flake.homeModules.home-zed-helix =
    { ... }:
    {
      # helix_mode already binds most of space mode (f b k s S d r a c p y /,
      # space w …); these add what the VSCodium setup had on top.
      programs.zed-editor.userKeymaps = [
        {
          context = "Editor && (vim_mode == helix_normal || vim_mode == helix_select) && !menu";
          bindings = {
            # space: pickers
            "space shift-f" = "projects::OpenRecent";
            "space j" = "pane::AlternateFile";
            "space ?" = "command_palette::Toggle";
            "space e" = "project_panel::ToggleFocus";

            # space: lsp
            "space h" = "editor::FindAllReferences";
            "space shift-d" = "diagnostics::Deploy";
            "space g" = "debug_panel::ToggleFocus";

            # space q / Q — :buffer-close / :quit
            "space q" = "pane::CloseActiveItem";
            "space shift-q" = "workspace::CloseWindow";

            # space u … — toggles
            "space u w" = "editor::ToggleSoftWrap";
            "space u i" = "editor::ToggleInlayHints";
            "space u d" = "editor::ToggleInlineDiagnostics";
            "space u m" = "editor::ToggleMinimap";
            "space u z" = "workspace::ToggleZoom";

            # space l … — lsp
            "space l f" = "editor::Format";
            "space l l" = "dev::OpenLanguageServerLogs";
            "space l r" = "editor::RestartLanguageServer";
          };
        }

        {
          context = "Workspace";
          bindings = {
            "ctrl-tab" = "pane::ActivateNextItem";
            "ctrl-shift-tab" = "pane::ActivatePreviousItem";
          };
        }
      ];
    };
}
