{ ... }:
{
  flake.homeModules.home-zed-languages =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.elars.zed.flakePath = lib.mkOption {
        type = lib.types.str;
        default = "${config.home.homeDirectory}/copland";
        description = ''
          Absolute path to this flake on disk, used by nixd to evaluate
          NixOS / home-manager options for completion. Must be a real path,
          not a store path — nixd re-evaluates it live.
        '';
      };

      config.programs.zed-editor = {
        # Zed downloads these grammars / language servers on first start.
        extensions = [
          "nix"
          "toml"
          "ansible"
          "basher"
        ];

        # Pinned servers on Zed's PATH instead of Zed's own downloads.
        extraPackages = with pkgs; [
          nixd
          nixfmt
          rust-analyzer
          clang-tools
          ruff
          shellcheck
        ];

        userSettings = {
          # ── diagnostics — inline ≈ errorLens / helix inline-diagnostics ──
          diagnostics = {
            include_warnings = true;
            inline = {
              enabled = true;
              max_severity = "warning";
            };
          };

          load_direnv = "shell_hook"; # every repo here is a flake devShell

          lsp = {
            # ── nix ─────────────────────────────────────────────────────────
            nixd.settings.nixd = {
              formatting.command = [ "${pkgs.nixfmt}/bin/nixfmt" ];
              options = {
                nixos.expr = ''(builtins.getFlake "${config.elars.zed.flakePath}").nixosConfigurations.copland.options'';
                home-manager.expr = ''(builtins.getFlake "${config.elars.zed.flakePath}").nixosConfigurations.copland.options.home-manager.users.value.${config.home.username}'';
              };
            };

            # ── rust ────────────────────────────────────────────────────────
            rust-analyzer.initialization_options = {
              check.command = "clippy";
              checkOnSave = true;
              cargo.buildScripts.enable = true;
              procMacro.enable = true;
              inlayHints = {
                parameterHints.enable = true;
                typeHints.enable = true;
                chainingHints.enable = true;
                maxLength = 30; # = inlay-hints-length-limit
              };
              completion.callable.snippets = "add_parentheses";
              lens.enable = false;
              imports.granularity.group = "module";
            };

            # ── c / c++ — mesa, kernel (clangd reads compile_commands.json) ─
            clangd.binary = {
              path = "${pkgs.clang-tools}/bin/clangd";
              arguments = [
                "--background-index"
                "--clang-tidy"
                "--header-insertion=never"
                "--completion-style=detailed"
                "--pch-storage=memory"
                "-j=4"
              ];
            };
          };

          languages = {
            Nix = {
              tab_size = 2;
              language_servers = [
                "nixd"
                "!nil"
              ];
              formatter.external.command = "${pkgs.nixfmt}/bin/nixfmt";
            };
            # VSCodium ran ruff only, no type checker.
            Python = {
              language_servers = [ "ruff" ];
              formatter.language_server.name = "ruff";
            };
            "Shell Script".tab_size = 2;
          };
        };
      };
    };
}
