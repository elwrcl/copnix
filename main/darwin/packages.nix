{ pkgs }:

with pkgs;
{
  system = [
    pinentry_mac
    fastfetch
    starship
    clinfo
    zoxide
    unzip
    gnupg
    btop
    htop
    tree
    wget
    eza
    bat
    git
    fzf
    zip
    fd
  ];
}
