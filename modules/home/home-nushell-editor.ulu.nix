{ ... }:
{
  flake.homeModules.home-nushell-editor =
    { ... }:
    {
      programs.nushell = {
        environmentVariables = {
          EDITOR = "hx";
          VISUAL = "hx";
        };

        shellAliases = {
          e = "hx";
          cop = "ide ~/copland";
        };
        #/nu/#
        extraConfig = ''
          def hxf [] {
            let picked = (
              do {
                fd --type f --hidden --exclude .git
                | fzf --preview 'bat --color=always --style=numbers {}'
              } | complete
            )

            if $picked.exit_code != 0 { return }

            let file = ($picked.stdout | str trim)
            if ($file | is-not-empty) { hx $file }
          }

          def hxd [rev: string = "@"] {
            let files = (
              jj diff --revision $rev --name-only
              | lines
              | where { |line| ($line | str trim) != "" }
            )

            if ($files | is-empty) {
              print $"(ansi yellow)($rev) no changes (ansi reset)"
              return
            }

            hx ...$files
          }
        '';
      };
    };
}
