{ ... }:
{
  flake.homeModules.home-helix-languages =
    { config, ... }:
    let
      flakeRoot = "${config.home.homeDirectory}/copland";
    in
    {
      programs.helix.languages = {
        language-server = {
          nixd.config.nixd = {
            formatting.command = [ "nixfmt" ];
            nixpkgs.expr = ''import (builtins.getFlake "${flakeRoot}").inputs.nixpkgs { }'';
            options = {
              nixos.expr = ''(builtins.getFlake "${flakeRoot}").nixosConfigurations.copland.options'';
              home-manager.expr = ''(builtins.getFlake "${flakeRoot}").nixosConfigurations.copland.options.home-manager.users.type.getSubOptions [ ]'';
            };
          };

          # fallback
          nil.config.nil.formatting.command = [ "nixfmt" ];

          rust-analyzer.config = {
            check.command = "clippy";
            cargo.buildScripts.enable = true;
            procMacro.enable = true;
            inlayHints = {
              bindingModeHints.enable = true;
              closingBraceHints.minLines = 10;
              closureReturnTypeHints.enable = "with_block";
              discriminantHints.enable = "fieldless";
              lifetimeElisionHints.enable = "skip_trivial";
              typeHints.hideClosureInitialization = false;
            };
          };

          gopls.config = {
            staticcheck = true;
            gofumpt = true;
            hints = {
              assignVariableTypes = true;
              compositeLiteralFields = true;
              constantValues = true;
              functionTypeParameters = true;
              parameterNames = true;
              rangeVariableTypes = true;
            };
          };

          pyright.config.python.analysis = {
            typeCheckingMode = "basic";
            autoImportCompletions = true;
          };

          typescript-language-server.config.typescript.inlayHints = {
            includeInlayEnumMemberValueHints = true;
            includeInlayFunctionLikeReturnTypeHints = true;
            includeInlayFunctionParameterTypeHints = true;
            includeInlayParameterNameHints = "all";
            includeInlayPropertyDeclarationTypeHints = true;
            includeInlayVariableTypeHints = true;
          };

          biome = {
            command = "biome";
            args = [ "lsp-proxy" ];
          };

          yaml-language-server.config.yaml = {
            format.enable = true;
            validate = true;
            schemas = {
              "https://json.schemastore.org/github-workflow.json" = ".github/workflows/*.{yml,yaml}";
              "https://json.schemastore.org/github-action.json" = "action.{yml,yaml}";
              "https://json.schemastore.org/docker-compose.json" = "docker-compose*.{yml,yaml}";
            };
          };

          lua-language-server.config.Lua = {
            hint.enable = true;
            telemetry.enable = false;
          };
        };

        language = [
          {
            name = "nix";
            language-servers = [
              "nixd"
              "nil"
            ];
            auto-format = true;
            formatter.command = "nixfmt";
          }
          {
            name = "rust";
            auto-format = true;
          }
          {
            name = "python";
            language-servers = [
              "ruff"
              "pyright"
            ];
            auto-format = true;
            formatter = {
              command = "ruff";
              args = [
                "format"
                "-"
              ];
            };
          }
          {
            name = "go";
            language-servers = [ "gopls" ];
            auto-format = true;
          }
          {
            name = "zig";
            auto-format = true;
            formatter = {
              command = "zig";
              args = [
                "fmt"
                "--stdin"
              ];
            };
          }
          {
            name = "haskell";
            auto-format = true;
          }
          {
            name = "java";
            language-servers = [ "jdtls" ];
            auto-format = true;
          }
          {
            name = "c";
            auto-format = true;
          }
          {
            name = "cpp";
            auto-format = true;
          }
          {
            name = "lua";
            auto-format = true;
            formatter = {
              command = "stylua";
              args = [ "-" ];
            };
          }
          {
            name = "bash";
            auto-format = true;
            formatter = {
              command = "shfmt";
              args = [
                "-i"
                "2"
                "-ci"
                "-s"
                "-"
              ];
            };
          }
          {
            name = "typescript";
            language-servers = [
              "typescript-language-server"
              "biome"
            ];
            auto-format = true;
            formatter = {
              command = "biome";
              args = [
                "format"
                "--stdin-file-path"
                "f.ts"
              ];
            };
          }
          {
            name = "tsx";
            language-servers = [
              "typescript-language-server"
              "biome"
            ];
            auto-format = true;
            formatter = {
              command = "biome";
              args = [
                "format"
                "--stdin-file-path"
                "f.tsx"
              ];
            };
          }
          {
            name = "javascript";
            language-servers = [
              "typescript-language-server"
              "biome"
            ];
            auto-format = true;
            formatter = {
              command = "biome";
              args = [
                "format"
                "--stdin-file-path"
                "f.js"
              ];
            };
          }
          {
            name = "jsx";
            language-servers = [
              "typescript-language-server"
              "biome"
            ];
            auto-format = true;
            formatter = {
              command = "biome";
              args = [
                "format"
                "--stdin-file-path"
                "f.jsx"
              ];
            };
          }
          {
            name = "json";
            auto-format = true;
            formatter = {
              command = "biome";
              args = [
                "format"
                "--stdin-file-path"
                "f.json"
              ];
            };
          }
          {
            name = "toml";
            language-servers = [ "taplo" ];
            auto-format = true;
            formatter = {
              command = "taplo";
              args = [
                "fmt"
                "-"
              ];
            };
          }
          {
            name = "yaml";
            language-servers = [ "yaml-language-server" ];
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "yaml"
              ];
            };
          }
          {
            name = "markdown";
            language-servers = [ "marksman" ];
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "markdown"
              ];
            };
            soft-wrap = {
              enable = true;
              wrap-at-text-width = true;
            };
          }
          {
            # Written every time `jj describe`/`jj commit` opens $EDITOR.
            name = "jjdescription";
            rulers = [
              51
              73
            ];
            text-width = 72;
            auto-format = false;
          }
          {
            name = "git-commit";
            auto-format = false;
          }
        ];
      };
    };
}
