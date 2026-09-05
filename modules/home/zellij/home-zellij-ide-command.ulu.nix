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
            pkgs.gawk
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

            if zellij list-sessions --no-formatting 2>/dev/null |
               awk -v s="$session" '$1 == s && $0 !~ /EXITED/ { hit = 1 } END { exit !hit }'; then
               exec zellij attach "$session"
             fi

             # Drop any dead session squatting on the name so the layout is rebuilt
             # from scratch rather than resurrected.
             zellij delete-session "$session" >/dev/null 2>&1 || true

             exec zellij --session "$session" --new-session-with-layout ide
          '';
        })
      ];
    };
}
