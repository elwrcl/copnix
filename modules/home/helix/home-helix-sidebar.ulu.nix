{ ... }:
{
  flake.homeModules.home-helix-sidebar =
    { config, pkgs, ... }:
    let
      open = pkgs.writeShellApplication {
        name = "hx-open";
        runtimeInputs = [
          config.programs.zellij.finalPackage
          pkgs.gnused
        ];
        text = ''
          if [ "$#" -eq 0 ]; then
            exit 0
          fi
          quote() {
            printf "'%s'" "$(printf '%s' "$1" | sed "s/'/&&/g")"
          }
          zellij action move-focus right >/dev/null 2>&1 || true

          if [ "$#" -eq 1 ] && [ -d "$1" ]; then
            command=":cd $(quote "$1")"
          else
            args=""
            for path in "$@"; do
              args="$args $(quote "$path")"
            done
            command=":open$args"
          fi

          zellij action write 27 >/dev/null 2>&1
          zellij action write-chars "$command" >/dev/null 2>&1
          zellij action write 13 >/dev/null 2>&1
        '';
      };

      sidebarConfig = pkgs.writeTextDir "yazi.toml" ''
        [mgr]
        ratio = [ 1, 1, 2 ]
        show_hidden = false
        show_symlink = true
        linemode = "size"
        scrolloff = 4
        sort_by = "natural"
        sort_dir_first = true

        [[plugin.prepend_fetchers]]
        url = "*"
        run = "git"
        group = "git"

        [[plugin.prepend_fetchers]]
        url = "*/"
        run = "git"
        group = "git"

        [opener]
        edit = [
          { run = '$EDITOR "$@"', block = false, for = "unix" },
        ]
      '';

      sidebar = pkgs.writeShellApplication {
        name = "hx-sidebar";
        runtimeInputs = [
          pkgs.yazi
          pkgs.git
        ];
        text = ''
          cd "''${1:-.}"

          export YAZI_CONFIG_HOME=${sidebarConfig}
          export EDITOR=${open}/bin/hx-open
          export VISUAL="$EDITOR"

          echo $$ > "''${XDG_RUNTIME_DIR:-/tmp}/hx-sidebar.''${ZELLIJ_SESSION_NAME:-none}"
          exec yazi .
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
          pid=""
          if [ -r "$marker" ]; then
            pid=$(cat "$marker")
          fi

          if [ -n "$pid" ] && [ "$(cat "/proc/$pid/comm" 2>/dev/null || true)" = "yazi" ]; then
            kill "$pid"
            rm -f "$marker"
            exit 0
          fi

          rm -f "$marker"

          id=$(zellij action new-pane \
            --direction right \
            --name files \
            --close-on-exit \
            -- ${sidebar}/bin/hx-sidebar "$PWD")

          zellij action move-pane --pane-id "$id" left >/dev/null
          for _ in 1 2 3 4 5; do
            zellij action resize --pane-id "$id" decrease right >/dev/null 2>&1
          done
        '';
      };
    in
    {
      home.packages = [
        open
        sidebar
        toggle
      ];
    };
}
