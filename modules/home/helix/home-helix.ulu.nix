{ ... }:
{
  flake.homeModules.home-helix =
    { ... }:
    {
      programs.helix = {
        enable = true;
        defaultEditor = true;

        settings = {
          theme = "kemuri-copnix";

          editor = {
            line-number = "relative";
            cursorline = true;
            color-modes = true;
            bufferline = "multiple";
            scrolloff = 8;
            rulers = [
              80
              100
            ];
            text-width = 80;

            true-color = true;
            undercurl = true;
            popup-border = "all";

            shell = [
              "nu"
              "--no-config-file"
              "-c"
            ];

            idle-timeout = 50;
            completion-timeout = 5;
            completion-trigger-len = 1;
            preview-completion-insert = true;
            trim-trailing-whitespace = true;
            trim-final-newlines = true;
            end-of-line-diagnostics = "hint";

            statusline = {
              left = [
                "mode"
                "spinner"
                "version-control"
                "file-name"
                "read-only-indicator"
                "file-modification-indicator"
              ];
              center = [ ];
              right = [
                "diagnostics"
                "workspace-diagnostics"
                "selections"
                "register"
                "position"
                "position-percentage"
                "file-type"
              ];
              mode = {
                normal = "NORMAL";
                insert = "INSERT";
                select = "SELECT";
              };
            };

            lsp = {
              display-messages = true;
              display-progress-messages = true;
              display-inlay-hints = true;
              auto-signature-help = true;
            };

            cursor-shape = {
              normal = "block";
              insert = "bar";
              select = "underline";
            };

            indent-guides = {
              render = true;
              character = "╎";
              skip-levels = 1;
            };

            inline-diagnostics = {
              cursor-line = "hint";
              other-lines = "error";
            };

            soft-wrap = {
              enable = true;
              wrap-indicator = "↪ ";
            };

            auto-save = {
              focus-lost = true;
              after-delay = {
                enable = false;
                timeout = 3000;
              };
            };

            file-picker = {
              hidden = false;
              git-ignore = true;
            };

            whitespace.characters = {
              nbsp = "⍽";
              tab = "→";
              tabpad = "·";
            };
          };
        };

        ignores = [
          "!.gitignore"
          "!.envrc"
          ".direnv/"
          ".jj/"
          "result"
          "result-*"
          "target/"
          "node_modules/"
        ];
      };
    };
}
