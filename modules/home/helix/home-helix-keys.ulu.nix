{ ... }:
{
  flake.homeModules.home-helix-keys =
    { ... }:
    let
      float = cmd: ":sh zellij run --floating --close-on-exit -- ${cmd}";
      floatKeep = cmd: ":sh zellij run --floating -- ${cmd}";
    in
    {
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
            e = float "yazi";
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
          };
        };
      };
    };
}
