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

  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 10;
      background-opacity = 0.8;
      window-padding-x = 10;
      window-padding-y = 10;
    };
  };

  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  xdg.configFile = {
    "fastfetch".source = ./dots/fastfetch;
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
    btop
    kitty
    xdg-utils
    ani-cli

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
    github-copilot-cli
    nixpkgs-fmt
    gnumake
    sqlite
    openssl
    pkg-config
    aubio
    cargo-tauri
    trunk
    dioxus-cli
    uv
    python3.12-tkinter

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
    jellyfin-media-player
    calibre
    qalculate-gtk
    libqalculate
    blender
    wine

    inputs.copetch.packages.${system}.default
  ];
}
