{ ... }:
{
  flake.homeModules.home-helix-language-servers =
    { pkgs, ... }:
    {
      programs.helix.extraPackages = with pkgs; [
        # nix
        nixd
        nil
        nixfmt

        # rust
        rust-analyzer
        rustfmt

        # python
        pyright
        ruff

        # go
        gopls
        gotools

        # zig / haskell / java
        zls
        zig
        haskell-language-server
        jdt-language-server

        # web
        typescript-language-server
        typescript
        biome
        vscode-langservers-extracted
        prettier

        # lua
        lua-language-server
        stylua

        # c/c++
        clang-tools

        # shell
        bash-language-server
        shfmt
        taplo
        yaml-language-server

        # markdown
        marksman

        # debug adapters (`space G`)
        lldb # lldb-dap: rust, c, c++, zig
        delve # dlv: go

        # `editor.shell` path
        nushell
        wl-clipboard
      ];
    };
}
