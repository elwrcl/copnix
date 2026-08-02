{ ... }:
{
  flake.homeModules.home-jujutsu-mergiraf =
    { pkgs, lib, ... }:
    let
      inherit (lib.meta) getExe;
    in
    {
      home.packages = [ pkgs.mergiraf ];

      programs.jujutsu.settings = {
        aliases.resolve-ast = [
          "resolve"
          "--tool"
          "mergiraf"
        ];

        merge-tools.mergiraf.program = getExe pkgs.mergiraf;
      };
    };
}
