{ ... }:
{
  flake.homeModules.home-vscode-helix =
    { ... }:
    # auto-generated
    let
      hx = "editorTextFocus && (extension.helixKeymap.normalMode || extension.helixKeymap.visualMode)";

      bind = key: command: {
        inherit key command;
        when = hx;
      };
    in
    {
      programs.vscodium.profiles.default = {
        userSettings = {
          "helixKeymap.toggleRelativeLineNumbers" = true;
          "extensions.experimental.affinity"."jasew.vscode-helix-emulation" = 1;
        };

        keybindings = [
          # space: pickers
          (bind "space f" "workbench.action.quickOpen")
          (bind "space shift+f" "workbench.action.openRecent")
          (bind "space b" "workbench.action.showAllEditors")
          (bind "space j" "workbench.action.quickOpenPreviousRecentlyUsedEditor")
          (bind "space s" "workbench.action.gotoSymbol")
          (bind "space shift+s" "workbench.action.showAllSymbols")
          (bind "space slash" "workbench.action.findInFiles")
          (bind "space shift+/" "workbench.action.showCommands")
          (bind "space e" "workbench.view.explorer")

          # space: lsp
          (bind "space k" "editor.action.showHover")
          (bind "space r" "editor.action.rename")
          (bind "space a" "editor.action.quickFix")
          (bind "space h" "editor.action.referenceSearch.trigger")
          (bind "space d" "workbench.actions.view.problems")
          (bind "space shift+d" "workbench.actions.view.problems")
          (bind "space g" "workbench.view.debug")

          # space: clipboard
          (bind "space y" "editor.action.clipboardCopyAction")
          (bind "space p" "editor.action.clipboardPasteAction")

          # space: window mode — hand back to the extension
          (bind "space w" "extension.helixKeymap.enterWindowMode")

          # space q / Q — :buffer-close / :quit
          (bind "space q" "workbench.action.closeActiveEditor")
          (bind "space shift+q" "workbench.action.closeWindow")

          # space u … — toggles
          (bind "space u w" "editor.action.toggleWordWrap")
          (bind "space u i" "editor.action.toggleInlayHints")
          (bind "space u h" "editor.action.toggleRenderWhitespace")
          (bind "space u d" "errorLens.toggle")
          (bind "space u m" "editor.action.toggleMinimap")
          (bind "space u s" "editor.action.toggleStickyScroll")
          (bind "space u z" "workbench.action.toggleZenMode")

          # space l … — lsp. VS Code has no generic :lsp-restart; bouncing the
          # extension host is the one command that restarts every server.
          (bind "space l f" "editor.action.formatDocument")
          (bind "space l l" "workbench.action.output.toggleOutput")
          (bind "space l r" "workbench.action.restartExtensionHost")

          # buffers — C-tab / C-S-tab without the MRU picker
          {
            key = "ctrl+tab";
            command = "workbench.action.nextEditor";
            when = "!extension.helixKeymap.insertMode";
          }
          {
            key = "ctrl+shift+tab";
            command = "workbench.action.previousEditor";
            when = "!extension.helixKeymap.insertMode";
          }

          # escape returns to the buffer from any panel
          {
            key = "escape";
            command = "workbench.action.focusActiveEditorGroup";
            when = "sideBarFocus && !inputFocus";
          }
          {
            key = "escape";
            command = "workbench.action.closePanel";
            when = "panelFocus && !terminalFocus && !inputFocus";
          }

          # unbind VS Code defaults that fight modal editing
          {
            key = "ctrl+shift+k";
            command = "-editor.action.deleteLines";
          }
          {
            key = "ctrl+enter";
            command = "-editor.action.insertLineAfter";
          }
          {
            key = "ctrl+shift+enter";
            command = "-editor.action.insertLineBefore";
          }
          {
            key = "tab";
            command = "-acceptSelectedSuggestion";
            when = "suggestWidgetVisible";
          }
        ];
      };
    };
}
