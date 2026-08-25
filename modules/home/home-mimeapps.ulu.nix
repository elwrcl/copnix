{ ... }:
{
  flake.homeModules.home-mimeapps =
    { ... }:
    {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory"          = [ "thunar.desktop" ];
          "x-scheme-handler/about"   = [ "helium.desktop" ];
          "x-scheme-handler/unknown" = [ "helium.desktop" ];
        };
      };
    };
}