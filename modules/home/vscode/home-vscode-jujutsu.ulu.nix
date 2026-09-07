{ ... }:
{
  flake.homeModules.home-vscode-jujutsu =
    { pkgs, ... }:
    let
      hx = "editorTextFocus && (extension.helixKeymap.normalMode || extension.helixKeymap.visualMode)";
      bind = key: command: {
        inherit key command;
        when = hx;
      };
      bindTask = key: name: {
        inherit key;
        command = "workbench.action.tasks.runTask";
        args = name;
        when = hx;
      };
    in
    {
      programs.vscodium.profiles.default = {
        extensions = [ pkgs.vscode-extensions.jjk.jjk ];
        userSettings = {
          "jjk.jjPath" = "${pkgs.jujutsu}/bin/jj";
          "git.enabled" = false; # jj confilict
        };
        keybindings = [
          (bind "space v s" "workbench.view.scm")
          (bind "space v d" "jj.openDiffEditor")
          (bind "space v n" "workbench.action.editor.nextChange")
          (bind "space v p" "workbench.action.editor.previousChange")
          (bind "space v c" "jj.new") # jj commit ≈ describe + new
          (bind "space v e" "jj.describe")
          (bind "space v f" "jj.gitFetch")
          (bind "space v u" "jj.operationUndo")
          (bind "space v m" "jj.showBookmarkMenu")
          (bind "space v r" "jj.refresh")
          (bindTask "space v v" "lazyjj")
          (bindTask "space v g" "lazygit")
          (bindTask "space v l" "jj log")
        ];

        userTasks = {
          version = "2.0.0";
          tasks =
            let
              task = close: label: command: {
                inherit label command;
                type = "shell";
                presentation = {
                  inherit close;
                  reveal = "always";
                  panel = "dedicated";
                  clear = true;
                  echo = false;
                  showReuseMessage = false;
                };
                problemMatcher = [ ];
              };
              tui = task true;
              run = task false;
            in
            [
              (tui "lazyjj" "${pkgs.lazyjj}/bin/lazyjj")
              (tui "lazygit" "${pkgs.lazygit}/bin/lazygit")
              (run "jj log" "${pkgs.jujutsu}/bin/jj log")
            ];
        };
      };
    };
}
