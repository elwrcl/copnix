{ inputs, ... }:
{
  flake.homeModules.home-icons =
    { pkgs, ... }:
    {
      gtk.iconTheme = {
        name = "int_nord";
        package = inputs.theme-assets.packages.${pkgs.stdenv.hostPlatform.system}.int-nord-icon-theme;
      };

    };
}
