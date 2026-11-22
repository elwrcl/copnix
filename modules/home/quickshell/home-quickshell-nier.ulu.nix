{ ... }:
{
  flake.homeModules.home-quickshell-nier =
    { pkgs, ... }:
    {
      # ported and changed from samyns/Unit-3;
      home.packages = [
        pkgs.quickshell
        (pkgs.google-fonts.override { fonts = [ "ShareTechMono" ]; })
      ];

      xdg.configFile."quickshell/nier".source = ./nier;
    };
}
