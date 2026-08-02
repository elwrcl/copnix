{ ... }:
{
  flake.homeModules.home-nushell-commandline-copy =
    { ... }:
    {
      programs.nushell.extraConfig = ''
        use std/clip
        def nu-highlight-default [] {

          let input = $in
          $env.config.color_config = {}
          $input | nu-highlight
        }

        def "nu-keybind commandline-copy" []: nothing -> nothing {
          commandline
          | nu-highlight-default
          | [ "```ansi" $in "```" ]
          | str join (char nl)
          | clip copy --ansi
        }

        $env.config.keybindings ++= [
          {
            name: copy_color_commandline
            modifier: control_alt
            keycode: char_c
            mode: [ emacs vi_insert vi_normal ]
            event: {
              send: executehostcommand
              cmd: 'nu-keybind commandline-copy'
            }
          }
        ]
      '';
    };
}
