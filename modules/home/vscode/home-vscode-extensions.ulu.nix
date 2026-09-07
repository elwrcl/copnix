{ ... }:
{
  flake.homeModules.home-vscode-extensions =
    { pkgs, ... }:
    let
      vscode-helix = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          publisher = "jasew";
          name = "vscode-helix-emulation";
          version = "0.7.0";
          hash = "sha256-gYyIVnXG9Atmik0c1FsRKO2idFnufwl26nOiH3DYPLY=";
        };
        meta.description = "Helix keybindings and commands for VS Code";
      };

      symbols = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          publisher = "miguelsolorio";
          name = "symbols";
          version = "0.0.26";
          hash = "sha256-UrkFmwwqMUsCuwZN2/t8ueDQBZ1WEzTF9IqirmTAZZU=";
        };
        meta.description = "Symbols icon theme for VS Code";
      };

      open-remote-ssh = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          publisher = "jeanp413";
          name = "open-remote-ssh";
          version = "0.3.1";
        };

        vsix = pkgs.fetchurl {
          url = "https://open-vsx.org/api/jeanp413/open-remote-ssh/0.3.1/file/jeanp413.open-remote-ssh-0.3.1.vsix";
          hash = "sha256-xvFrIlq4aSXyvZ6Mxbox5hSXjM+hIPFQm99umeW+8T8=";
          name = "jeanp413-open-remote-ssh.vsix";
        };
        meta.description = "Remote SSH for VSCodium / Open VSX builds";
      };

      gutter-preview = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          publisher = "kisstkondoros";
          name = "vscode-gutter-preview";
          version = "0.32.2";
          hash = "sha256-JIr4UGuwy9Z5oH8D8elGMBGP8s40pYLCEZGmJAO5Ga0=";
        };
        meta.description = "Image preview in the gutter";
      };
    in
    {
      programs.vscodium.profiles.default.extensions = [
        vscode-helix
        symbols
        open-remote-ssh
        gutter-preview
      ]
      ++ (with pkgs.vscode-extensions; [

        # nix
        jnoortheen.nix-ide

        # rust
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        vadimcn.vscode-lldb

        # c / c++ —
        llvm-vs-code-extensions.vscode-clangd

        # python
        ms-python.python
        charliermarsh.ruff

        # ansible / yaml / shell
        redhat.vscode-yaml
        redhat.ansible
        timonwong.shellcheck

        # workflow
        mkhl.direnv
        usernamehw.errorlens
        editorconfig.editorconfig
        alefragnani.bookmarks
        aaron-bond.better-comments

        # agent
        anthropic.claude-code
      ]);
    };
}
