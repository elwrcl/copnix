{
  pkgs,
}:

with pkgs;
{
  system = [
    eza
    bat
    fd
    fzf
    zoxide
    starship
    fastfetch
    btop
    git
    wget
    htop
    tree
    unzip
    zip
    gnupg
    pinentry_mac
  ];
}
