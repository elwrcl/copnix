{ ... }:
{
  flake.homeModules.home-ghidra =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.ghidra ];
      home.sessionVariables.GHIDRA_INSTALL_DIR = "${pkgs.ghidra}/lib/ghidra";
    };
}
