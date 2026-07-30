{ ... }:
{
  flake.homeModules.home-mimeapps =
    { ... }:
    {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory" = [ "org.kde.dolphin.desktop" ];
          "x-scheme-handler/http" = [ "zen-beta.desktop" ];
          "x-scheme-handler/https" = [ "zen-beta.desktop" ];
          "x-scheme-handler/about" = [ "zen-beta.desktop" ];
          "x-scheme-handler/unknown" = [ "zen-beta.desktop" ];
        };
      };
    };
}
