{ ... }:
{
  # auto-generated
  flake.homeModules.home-vscode-languages =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.elars.vscode.flakePath = lib.mkOption {
        type = lib.types.str;
        default = "${config.home.homeDirectory}/copland";
        description = ''
          Absolute path to this flake on disk, used by nixd to evaluate
          NixOS / home-manager options for completion. Must be a real path,
          not a store path — nixd re-evaluates it live. Checkout dizini
          `copland` (GitHub deposunun adı `copnix`, aynı şey değil).
        '';
      };

      config.programs.vscodium.profiles.default.userSettings = {
        # ── nix ─────────────────────────────────────────────────────────────
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.tabSize" = 2;
        };
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
        "nix.formatterPath" = [ "${pkgs.nixfmt}/bin/nixfmt" ];
        "nix.serverSettings".nixd = {
          formatting.command = [ "${pkgs.nixfmt}/bin/nixfmt" ];
          options = {
            nixos.expr = ''(builtins.getFlake "${config.elars.vscode.flakePath}").nixosConfigurations.copland.options'';
            home-manager.expr = ''(builtins.getFlake "${config.elars.vscode.flakePath}").nixosConfigurations.copland.options.home-manager.users.value.${config.home.username}'';
          };
        };

        # ── rust ────────────────────────────────────────────────────────────
        "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "rust-analyzer.check.command" = "clippy";
        "rust-analyzer.checkOnSave" = true;
        "rust-analyzer.cargo.buildScripts.enable" = true;
        "rust-analyzer.procMacro.enable" = true;
        "rust-analyzer.inlayHints.parameterHints.enable" = true;
        "rust-analyzer.inlayHints.typeHints.enable" = true;
        "rust-analyzer.inlayHints.chainingHints.enable" = true;
        "rust-analyzer.inlayHints.maxLength" = 30; # = inlay-hints-length-limit
        "rust-analyzer.completion.callable.snippets" = "add_parentheses";
        "rust-analyzer.lens.enable" = false;
        "rust-analyzer.imports.granularity.group" = "module";

        # ── c / c++ — mesa, kernel (clangd reads compile_commands.json) ─────
        "[c]"."editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";
        "[cpp]"."editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";
        "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
        "clangd.arguments" = [
          "--background-index"
          "--clang-tidy"
          "--header-insertion=never"
          "--completion-style=detailed"
          "--pch-storage=memory"
          "-j=4"
        ];
        "clangd.onConfigChanged" = "restart";

        # ── python / shell / data ───────────────────────────────────────────
        "[python]"."editor.defaultFormatter" = "charliermarsh.ruff";
        "python.languageServer" = "None";
        "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python3";
        "[yaml]"."editor.defaultFormatter" = "redhat.vscode-yaml";
        "[markdown]"."editor.defaultFormatter" = "vscode.markdown-language-features";
        "[json]"."editor.defaultFormatter" = "vscode.json-language-features";
        "[jsonc]"."editor.defaultFormatter" = "vscode.json-language-features";
        "[shellscript]"."editor.tabSize" = 2;

        # ── diagnostics — errorLens ≈ helix inline-diagnostics ──────────────
        "errorLens.enabled" = true;
        "errorLens.enabledDiagnosticLevels" = [
          "error"
          "warning"
        ];
        "errorLens.messageBackgroundMode" = "none";
        "errorLens.gutterIconsEnabled" = false;
        "errorLens.fontStyleItalic" = true;
        "errorLens.followCursor" = "allLines";
        "errorLens.messageTemplate" = "$message";
        "problems.showCurrentInStatus" = true;

        # ── direnv — every repo here is a flake devShell ────────────────────
        "direnv.restart.automatic" = true;
      };
    };
}
