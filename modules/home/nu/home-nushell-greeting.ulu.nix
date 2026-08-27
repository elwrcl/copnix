{ ... }:
{
  flake.homeModules.home-nushell-greeting =
    { config, lib, ... }:
    let
      nyi = lib.getExe config.programs.nyi.package;
    in
    {
      programs.nushell.extraConfig = ''
        if $nu.is-interactive and ($env.ZELLIJ? | is-empty) {
          ^${nyi} --frames 60
        }
      '';
    };
}
