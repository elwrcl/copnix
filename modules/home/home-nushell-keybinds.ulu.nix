{ ... }:
{
  flake.homeModules.home-nushell-keybinds =
    { ... }:
    {
      programs.nushell.extraConfig = ''
        $env.config.keybindings ++= [
          {
            name: jj_status
            modifier: control
            keycode: char_g
            mode: [ emacs vi_insert vi_normal ]
            event: { send: executehostcommand, cmd: "jj status" }
          }
          {
            name: jj_log
            modifier: alt
            keycode: char_l
            mode: [ emacs vi_insert vi_normal ]
            event: { send: executehostcommand, cmd: "jj log" }
          }
          {
            name: jj_diff
            modifier: alt
            keycode: char_d
            mode: [ emacs vi_insert vi_normal ]
            event: { send: executehostcommand, cmd: "jj diff" }
          }
        ]
      '';
    };
}
