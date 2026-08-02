{ ... }:
{
  flake.homeModules.home-nushell-commandline-copy =
    { pkgs, lib, ... }:
    let
      inherit (lib.meta) getExe';
      wlCopy = getExe' pkgs.wl-clipboard "wl-copy";
    in
    {
      home.packages = [ pkgs.wl-clipboard ];

      programs.nushell.extraConfig = ''
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
          | ^${wlCopy}
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
