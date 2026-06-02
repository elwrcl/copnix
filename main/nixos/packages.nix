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
    nemo-with-extensions
    whatsapp-electron
    telegram-desktop
    prismlauncher
    qbittorrent
    antigravity
    obs-studio
    localsend
    spotatui
    picotool
    equibop
    ghostty
    blender
    heroic
    loupe
    wine

    # hyprland
    gpu-screen-recorder
    wl-clipboard
    wf-recorder
    tesseract
    mpvpaper
    swappy
    waybar
    slurp
    grim
    rofi
    cava
    eww

    # phone
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
    whitesur-icon-theme
    gnome-themes-extra
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
