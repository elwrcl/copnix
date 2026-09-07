{ ... }:
{
  flake.nixosModules.desktop-xdg-mime =
    { pkgs, ... }:
    {
      xdg = {
        mime = {
          enable = true;

          defaultApplications = {
            # gui
            "text/html" = "helium.desktop";
            "x-scheme-handler/http" = "helium.desktop";
            "x-scheme-handler/https" = "helium.desktop";
            "x-scheme-handler/about" = "helium.desktop";
            "x-scheme-handler/unknown" = "helium.desktop";
            "x-scheme-handler/steam" = "steam.desktop";

            # media
            "image/png" = "org.gnome.Loupe.desktop";
            "image/jpeg" = "org.gnome.Loupe.desktop";
            "image/gif" = "org.gnome.Loupe.desktop";
            "image/bmp" = "org.gnome.Loupe.desktop";
            "image/svg+xml" = "org.gnome.Loupe.desktop";
            "image/webp" = "org.gnome.Loupe.desktop";
            "image/tiff" = "org.gnome.Loupe.desktop";
            "video/mp4" = "mpv.desktop";
            "video/x-matroska" = "mpv.desktop";
            "video/webm" = "mpv.desktop";
            "video/avi" = "mpv.desktop";
            "video/quicktime" = "mpv.desktop";
            "audio/mpeg" = "mpv.desktop";
            "audio/flac" = "mpv.desktop";
            "audio/ogg" = "mpv.desktop";

            # text
            "text/plain" = "codium.desktop";
            "text/x-rust" = "codium.desktop";
            "text/x-nix" = "codium.desktop";
            "text/x-csrc" = "codium.desktop";
            "text/x-chdr" = "codium.desktop";
            "text/x-python" = "codium.desktop";
            "text/x-shellscript" = "codium.desktop";
            "application/json" = "codium.desktop";
            "application/x-shellscript" = "codium.desktop";
          };
        };

        menus.enable = true;
      };

      environment.etc."xdg/menus/applications.menu".text =
        builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
    };
}
