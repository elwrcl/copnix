{ ... }:
{
  flake.darwinModules.common-packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
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
    };
}
