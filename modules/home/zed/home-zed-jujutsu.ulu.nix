{ ... }:
{
  flake.homeModules.home-zed-jujutsu =
    { pkgs, ... }:
    let
      jj = "${pkgs.jujutsu}/bin/jj";
      tui = label: command: {
        inherit label command;
        use_new_terminal = true;
        allow_concurrent_runs = false;
        reveal = "always";
        hide = "on_success";
      };
      run = label: args: {
        inherit label args;
        command = jj;
        reveal = "always";
        hide = "never";
      };
      runFile =
        label: args:
        run label args
        // {
          cwd = "$ZED_DIRNAME";
          save = "current";
        };
      file = ''file:"$ZED_FILE"'';

      spawn = task_name: [
        "task::Spawn"
        { inherit task_name; }
      ];
    in
    {
      programs.zed-editor = {
        userTasks = [
          (tui "jjui" "${pkgs.jjui}/bin/jjui")
          (tui "lazyjj" "${pkgs.lazyjj}/bin/lazyjj")
          (tui "lazygit" "${pkgs.lazygit}/bin/lazygit")
          (tui "jj describe" "${jj} describe")
          (run "jj log" [ "log" ])
          (run "jj new" [ "new" ])
          (run "jj git fetch" [
            "git"
            "fetch"
          ])
          (run "jj undo" [ "undo" ])
          (run "jj bookmark list" [
            "bookmark"
            "list"
          ])

          (runFile "jj diff (file)" [
            "diff"
            file
          ])
          (runFile "jj log (file)" [
            "log"
            file
          ])
          (runFile "jj annotate (file)" [
            "file"
            "annotate"
            "$ZED_FILE"
          ])
          (runFile "jj restore (file)" [
            "restore"
            file
          ])
          (runFile "jj squash (file)" [
            "squash"
            file
          ])
        ];

        userKeymaps = [
          {
            context = "Editor && (vim_mode == helix_normal || vim_mode == helix_select) && !menu";
            bindings = {
              "space v s" = "git_panel::ToggleFocus";
              "space v d" = "git::Diff";
              "space v n" = "editor::GoToHunk";
              "space v p" = "editor::GoToPreviousHunk";
              "space v r" = "git::Restore";
              "space v c" = spawn "jj new";
              "space v e" = spawn "jj describe";
              "space v f" = spawn "jj git fetch";
              "space v u" = spawn "jj undo";
              "space v m" = spawn "jj bookmark list";
              "space v v" = spawn "jjui";
              "space v shift-v" = spawn "lazyjj";
              "space v g" = spawn "lazygit";
              "space v l" = spawn "jj log";

              "space v shift-d" = spawn "jj diff (file)";
              "space v shift-l" = spawn "jj log (file)";
              "space v b" = spawn "jj annotate (file)";
              "space v shift-r" = spawn "jj restore (file)";
              "space v shift-s" = spawn "jj squash (file)";
            };
          }
        ];
      };
    };
}
