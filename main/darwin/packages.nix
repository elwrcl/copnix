{
  pkgs,
}:

with pkgs;
{
  system = [
    pkgs.eza
    pkgs.bat
    pkgs.fd
    pkgs.fzf
    pkgs.zoxide
    pkgs.starship
    pkgs.fastfetch
    pkgs.btop
    pkgs.git
    pkgs.wget
    pkgs.htop
    pkgs.tree
    pkgs.unzip
    pkgs.zip
    pkgs.gnupg
    pkgs.pinentry_mac
  ];
}
