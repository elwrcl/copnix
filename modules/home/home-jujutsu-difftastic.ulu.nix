{ ... }:
{
  flake.homeModules.home-jujutsu-difftastic =
    { pkgs, lib, ... }:
    let
      inherit (lib.meta) getExe;
    in
    {
      home.packages = [ pkgs.difftastic ];

      programs.jujutsu.settings.ui.diff-formatter = [
        (getExe pkgs.difftastic)
        "--color"
        "always"
        "$left"
        "$right"
      ];
    };
}
