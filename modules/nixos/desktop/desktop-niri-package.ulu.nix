{ ... }:
{
  flake.homeModules.desktop-niri-package =
    { pkgs, ... }:
    {
      programs.niri.package = pkgs.niri;
    };
}
