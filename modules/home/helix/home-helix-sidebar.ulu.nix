{ ... }:
{
  flake.homeModules.home-helix-sidebar =
    { config, pkgs, ... }:
    let
      sidebarConfig = pkgs.writeTextDir "yazi.toml" ''
        [mgr]
        ratio = [ 0, 1, 0 ]
        show_hidden = false
        show_symlink = false
        linemode = "none"
        scrolloff = 4
      '';

      sidebar = pkgs.writeShellApplication {
        name = "hx-sidebar";
        runtimeInputs = [
          pkgs.yazi
          config.programs.zellij.finalPackage
          pkgs.coreutils
        ];
        text = ''
          cd "''${1:-.}"

          export YAZI_CONFIG_HOME=${sidebarConfig}

          marker="''${XDG_RUNTIME_DIR:-/tmp}/hx-sidebar.''${ZELLIJ_SESSION_NAME:-none}"
          chooser=$(mktemp -t hx-sidebar.XXXXXX)
          trap 'rm -f "$chooser" "$marker"' EXIT
          echo $$ > "$marker"

          while true; do
            : > "$chooser"
            yazi . --chooser-file="$chooser"

            picked=$(head -n 1 "$chooser")
            [ -n "$picked" ] || break

            zellij action move-focus right
            zellij action write 27
            zellij action write-chars ":open '$picked'"
            zellij action write 13
          done
        '';
      };

      toggle = pkgs.writeShellApplication {
        name = "hx-sidebar-toggle";
        runtimeInputs = [
          config.programs.zellij.finalPackage
          pkgs.coreutils
        ];
        text = ''
          if [ -z "''${ZELLIJ_SESSION_NAME:-}" ]; then
            echo "hx-sidebar-toggle: not inside a zellij session" >&2
            exit 1
          fi

          marker="''${XDG_RUNTIME_DIR:-/tmp}/hx-sidebar.''${ZELLIJ_SESSION_NAME}"

          if [ -e "$marker" ] && kill -0 "$(cat "$marker")" 2>/dev/null; then
            zellij action toggle-fullscreen
          else
            rm -f "$marker"

            id=$(zellij action new-pane \
              --direction right \
              --name files \
              --close-on-exit \
              -- ${sidebar}/bin/hx-sidebar "$PWD")

            zellij action move-pane --pane-id "$id" left
            for _ in 1 2 3 4 5; do
              zellij action resize --pane-id "$id" decrease right
            done
          fi
        '';
      };
    in
    {
      home.packages = [
        sidebar
        toggle
      ];
    };
}
