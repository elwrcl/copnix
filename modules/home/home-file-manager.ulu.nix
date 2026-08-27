{ ... }:
{
  flake.homeModules.home-file-manager =
    { config, pkgs, ... }:
    let
      home = config.home.homeDirectory;
    in
    {
      home.packages = with pkgs; [
        kdePackages.dolphin
        kdePackages.dolphin-plugins
      ];
      home.file.".local/share/user-places.xbel".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <xbel xmlns:bookmark="http://www.freedesktop.org/standards/desktop-bookmarks"
              xmlns:kdepriv="http://www.kde.org/kdepriv">
          <bookmark href="file://${home}"><title>Home</title></bookmark>
          <bookmark href="file://${home}/copland"><title>nix</title></bookmark>
          <bookmark href="file://${home}/.config"><title>dotfiles</title></bookmark>
          <bookmark href="file://${home}/Documents"><title>documents</title></bookmark>
          <bookmark href="file://${home}/Downloads"><title>downloads</title></bookmark>
          <bookmark href="file://${home}/Music"><title>music</title></bookmark>
          <bookmark href="file://${home}/Pictures"><title>pictures</title></bookmark>
          <bookmark href="file://${home}/Videos"><title>videos</title></bookmark>
          <bookmark href="file://${home}/Videos_XFS"><title>videos-xfs</title></bookmark>
          <bookmark href="file://${home}/Projects"><title>projects</title></bookmark>
          <bookmark href="file://${home}/Projects_XFS"><title>projects-xfs</title></bookmark>
        </xbel>
      '';
    };
}
