{ ... }:
{
  flake.homeModules.home-zellij-ide-command =
    { config, pkgs, ... }:
    {
      home.packages = [
        (pkgs.writeShellApplication {
          name = "ide";
          runtimeInputs = [
            config.programs.zellij.finalPackage
            pkgs.coreutils
            pkgs.gnugrep
          ];
          text = ''
            case "''${1:-}" in
              -h | --help)
                echo "usage: ide [directory]"
                echo
                echo "opens re-attaches to a Zellij session named after the"
                echo "directory, running Helix in the 'ide' layout."
                exit 0
                ;;
            esac

            cd "''${1:-.}"

            session=$(basename "$PWD")
            session=$(printf '%s' "$session" | tr -c 'A-Za-z0-9._-' '-')

            if zellij list-sessions --short 2>/dev/null | grep -qx "$session"; then
              exec zellij attach "$session"
            fi

            exec zellij --session "$session" --new-session-with-layout ide
          '';
        })
      ];
    };
}
