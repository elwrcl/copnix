{ ... }:
{
  flake.homeModules.home-zsh-nu-handoff =
    { config, lib, ... }:
    let
      nu = lib.getExe config.programs.nushell.package;
    in
    {
      programs.zsh.initContent = lib.mkBefore ''
        if [[ -o interactive && -z "$NO_NU" && -z "$INSIDE_NU" ]]; then
          export INSIDE_NU=1
          exec ${nu}
        fi
      '';
    };
}
