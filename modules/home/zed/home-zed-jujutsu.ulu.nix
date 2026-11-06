{ ... }:
{
  flake.homeModules.home-zed-jujutsu =
    { pkgs, ... }:
    let
      jj = "${pkgs.jujutsu}/bin/jj";

      # Interactive tools take over a terminal and close it when done; one-shot
      # commands keep their output open.
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

      spawn = task_name: [
        "task::Spawn"
        { inherit task_name; }
      ];
    in
    {
      # Zed has no jj support; its git panel still reads colocated repos, and
      # jj itself runs as tasks.
      programs.zed-editor = {
        userTasks = [
          (tui "lazyjj" "${pkgs.lazyjj}/bin/lazyjj")
          (tui "lazygit" "${pkgs.lazygit}/bin/lazygit")
          (tui "jj describe" "${jj} describe")
          (run "jj log" [ "log" ])
          (run "jj new" [ "new" ]) # jj commit ≈ describe + new
          (run "jj git fetch" [
            "git"
            "fetch"
          ])
          (run "jj undo" [ "undo" ])
          (run "jj bookmark list" [
            "bookmark"
            "list"
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
              "space v c" = spawn "jj new";
              "space v e" = spawn "jj describe";
              "space v f" = spawn "jj git fetch";
              "space v u" = spawn "jj undo";
              "space v m" = spawn "jj bookmark list";
              "space v v" = spawn "lazyjj";
              "space v g" = spawn "lazygit";
              "space v l" = spawn "jj log";
            };
          }
        ];
      };
    };
}
