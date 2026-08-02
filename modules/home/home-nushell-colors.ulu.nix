{ ... }:
{
  flake.homeModules.home-nushell-colors =
    { pkgs, lib, ... }:
    let
      inherit (lib.meta) getExe;

      lsColors = pkgs.runCommand "ls_colors.txt" { } ''
        ${getExe pkgs.vivid} generate gruvbox-dark-hard > $out
      '';
    in
    {
      home.packages = [ pkgs.vivid ];

      programs.nushell.extraConfig = ''
        $env.LS_COLORS = open --raw ${lsColors}

        $env.config.color_config.row_index = "light_yellow_bold"
        $env.config.color_config.header = "light_yellow_bold"

        $env.config.color_config.bool = {||
          if $in {
            "light_green_bold"
          } else {
            "light_red_bold"
          }
        }

        $env.config.color_config.string = {||
          if $in =~ "^(#|0x)[a-fA-F0-9]+$" {
            $in | str replace "0x" "#"
          } else {
            "white"
          }
        }
      '';
    };
}
