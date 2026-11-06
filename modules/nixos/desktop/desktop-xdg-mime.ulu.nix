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
            "x-scheme-handler/magnet" = "org.qbittorrent.qBittorrent.desktop";
            "application/x-bittorrent" = "org.qbittorrent.qBittorrent.desktop";

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
            "text/plain" = "dev.zed.Zed.desktop";
            "text/x-rust" = "dev.zed.Zed.desktop";
            "text/x-nix" = "dev.zed.Zed.desktop";
            "text/x-csrc" = "dev.zed.Zed.desktop";
            "text/x-chdr" = "dev.zed.Zed.desktop";
            "text/x-python" = "dev.zed.Zed.desktop";
            "text/x-shellscript" = "dev.zed.Zed.desktop";
            "application/json" = "dev.zed.Zed.desktop";
            "application/x-shellscript" = "dev.zed.Zed.desktop";
          };
        };

        menus.enable = true;
      };
      environment.etc."xdg/menus/applications.menu".source = pkgs.runCommand "applications.menu" { } ''
        cp ${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu $out
      '';
    };
}
