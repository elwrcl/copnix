{
  pkgs,
  inputs,
  system,
  ...
}:

{
  home.username = "elars";
  home.stateVersion = "25.05";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = builtins.readFile ./dots/zsh/.zshrc;
  };

  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  xdg.configFile = {
  };

  home.packages = with pkgs; [
    # cli
    eza
    bat
    fd
    fastfetch
    zoxide
    trash-cli
    rsync
    tldr
    jq
    zip
    rar
    dos2unix
    unzip
    wget
    autossh
    direnv
    fish
    git
    cachix
    htop
    btop
    kitty
    xdg-utils
    ani-cli
    github-copilot-cli
    pkgs.ghostty_git

    # media
    mpv
    ffmpeg
    yt-dlp
    imagemagick
    cava
    pavucontrol
    playerctl
    pamixer

    # editors
    neovim
    vscode
    zed-editor

    # dev tools
    nil
    nixfmt
    gnumake
    sqlite
    openssl
    pkg-config
    aubio
    cargo-tauri
    trunk
    uv

    # langs
    ghc
    go
    rustup
    gcc
    binutils
    zig
    lua
    glm
    python3

    # themes/icons
    bibata-cursors
    gnome-themes-extra
    papirus-icon-theme
    adwaita-icon-theme
    adwaita-qt6

    # apps
    telegram-desktop
    onlyoffice-desktopeditors
    qbittorrent
    localsend
    blender
    wine

    inputs.copetch.packages.${system}.default
  ];
}
