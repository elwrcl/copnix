{ ... }:
{
  flake.homeModules.home-nushell-bash-compat =
    { ... }:
    {
      programs.nushell.extraConfig = ''
        $env.DIRSTACK = []
        def --env pushd [path: path] {
          $env.DIRSTACK = ($env.DIRSTACK | prepend $env.PWD)
          cd $path
        }

        def --env popd [] {
          if ($env.DIRSTACK | is-empty) {
            print $"(ansi red)popd: directory stack empty(ansi reset)"
          } else {
            let top = ($env.DIRSTACK | first)
            $env.DIRSTACK = ($env.DIRSTACK | skip 1)
            cd $top
          }
        }

        def dirs [] {
          [$env.PWD] | append $env.DIRSTACK
        }

        def bashc [command: string] {
          ^bash -lc $command
        }

        def rerun [] {
          let last = (history | last | get command)
          print $"(ansi grey)$ ($last)(ansi reset)"
          ^bash -lc $last
        }
      '';
    };
}
