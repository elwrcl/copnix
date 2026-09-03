{ ... }:
{
  flake.homeModules.home-helix-keys =
    { config, pkgs, ... }:
    let
      float = cmd: ":sh zellij run --floating --close-on-exit -- ${cmd}";
      floatKeep = cmd: ":sh zellij run --floating -- ${cmd}";
      pick = pkgs.writeShellApplication {
        name = "hx-pick";
        runtimeInputs = [
          pkgs.yazi
          config.programs.zellij.finalPackage
          pkgs.coreutils
        ];
        text = ''
          chooser=$(mktemp -t hx-pick.XXXXXX)
          trap 'rm -f "$chooser"' EXIT

          yazi "''${1:-.}" --chooser-file="$chooser"

          picked=$(head -n 1 "$chooser")
          [ -n "$picked" ] || exit 0

          zellij action toggle-floating-panes
          zellij action write-chars ":open '$picked'"
          zellij action write 13
        '';
      };
    in
    {
      home.packages = [ pick ];

      programs.helix.settings.keys = {
        normal = {
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];

          space = {
            q = ":buffer-close";
            Q = ":quit";
            t = float "nu";
            e = float "hx-pick";
            E = float "hx-pick %{buffer_name}";
            n = ":sh zellij action new-tab";
            z = ":sh zellij action toggle-floating-panes";

            v = {
              v = float "lazyjj";
              g = float "lazygit";
              s = floatKeep "jj status";
              l = floatKeep "jj log";
              d = floatKeep "jj diff %{buffer_name}";
              D = floatKeep "jj diff";
              b = floatKeep "jj file annotate %{buffer_name}";
              e = float "jj describe";
              c = float "jj commit";
              r = ":reset-diff-change";
              n = "goto_next_change";
              p = "goto_prev_change";
            };

            u = {
              w = ":toggle soft-wrap.enable";
              i = ":toggle lsp.display-inlay-hints";
              n = ":toggle line-number relative absolute";
              d = ":toggle inline-diagnostics.cursor-line hint disable";
              h = ":toggle whitespace.render all none";
              g = ":toggle indent-guides.render";
              c = ":toggle cursorline";
              f = ":toggle auto-format";
            };

            # language server
            l = {
              r = ":lsp-restart";
              s = ":lsp-stop";
              w = ":lsp-workspace-command";
              l = ":log-open";
              f = ":format";
            };
          };
        };
      };
    };
}
