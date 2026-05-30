{
  pkgs,
  inputs,
  system,
}:

let
  uxplay-fixed = pkgs.uxplay.override {
    avahi = pkgs.avahi.override { withLibdnssdCompat = true; };
  };
in
with pkgs;
{
  system = [
    # apps
    onlyoffice-desktopeditors
    whatsapp-electron
    pkgs.ghostty_git
    telegram-desktop
    prismlauncher
    qbittorrent
    antigravity
    localsend
    spotatui
    picotool
    equibop
    blender
    heroic
    loupe
    wine

    # qol-hyprland
    wl-clipboard
    wf-recorder
    obs-studio
    tesseract
    mpvpaper
    swappy
    slurp
    grim

    #thunar tools
    thunar-media-tags-plugin
    thunar-archive-plugin
    ffmpegthumbnailer
    thunar-volman
    tumbler
    thunar

    # phone
    kdePackages.krdp
    libimobiledevice
    android-tools
    uxplay-fixed
    usbmuxd
    libmtp
    jmtpfs
    scrcpy
    ifuse

    # cli
    github-copilot-cli
    fastfetch
    trash-cli
    dos2unix
    autossh
    ani-cli
    zoxide
    cachix
    direnv
    rsync
    unzip
    kitty
    tree
    tldr
    wget
    fish
    htop
    btop
    zip
    eza
    bat
    git
    rar
    jq
    fd

    # hardware
    gpu-screen-recorder
    intel-gpu-tools
    smartmontools
    brightnessctl
    gsmartcontrol
    vulkan-tools
    libva-utils
    mesa-demos
    lm_sensors
    exfatprogs
    libsecret
    gptfdisk
    usbutils
    hfsprogs
    dmg2img
    ddcutil
    clinfo
    hidapi
    parted
    p7zip
    xar

    # themes/icons
    papirus-icon-theme
    adwaita-icon-theme
    gnome-themes-extra
    hicolor-icon-theme
    gnome-icon-theme
    tango-icon-theme
    arc-icon-theme
    bibata-cursors
    adwaita-qt6
    adwaita-qt

    # langs
    binutils
    python3
    rustup
    gcc
    ghc
    go
    zig
    lua
    glm

    # dev tools
    cargo-tauri
    pkg-config
    gnumake
    openssl
    nixfmt
    sqlite
    aubio
    trunk
    nil
    uv

    # editors
    zed-editor
    neovim
    vscode

    # media
    imagemagick
    pavucontrol
    playerctl
    pamixer
    ffmpeg
    yt-dlp
    cava
    mpv

    inputs.zen-browser.packages.${system}.default
    inputs.noctalia.packages.${system}.default
    inputs.copetch.packages.${system}.default
    inputs.helium.packages.${system}.default
    pkgs.qt6Packages.qtwebsockets
    pkgs.evil-helix_git
  ];
}
