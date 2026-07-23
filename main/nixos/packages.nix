{
  pkgs,
  inputs,
  system,
  ...
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
    telegram-desktop
    prismlauncher
    moonlight-qt
    qbittorrent
    antigravity
    obs-studio
    localsend
    spotatui
    picotool
    sunshine
    equibop
    spotify
    ghostty
    heroic
    loupe
    gimp
    wine

    # file-manager
    kdePackages.kdegraphics-thumbnailers
    kdePackages.plasma-integration
    kdePackages.breeze-icons
    kdePackages.kio-extras
    kdePackages.qtwayland
    kdePackages.kio-admin
    kdePackages.kio-fuse
    kdePackages.kservice
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.ark
    kdePackages.kio
    kdePackages.kdf

    # utils
    poppler-utils
    wl-clipboard
    wf-recorder
    tesseract
    mpvpaper
    swappy
    slurp
    grim

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
    tailscale
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
    perf
    file
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
    xkeyboard-config
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
    apfs-fuse
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
    whitesur-gtk-theme
    gnome-themes-extra
    whitesur-kde
    adwaita-qt6
    adwaita-qt

    # langs
    alejandra
    binutils
    python3
    rustup
    nodejs
    jdk25
    gcc
    ghc
    zig
    lua
    glm
    go

    # dev tools
    jdt-language-server
    rust-analyzer
    clang-tools
    cargo-tauri
    pkg-config
    gnumake
    openssl
    pyright
    rustfmt
    lazygit
    nixfmt
    zellij
    sqlite
    aubio
    delta
    trunk
    nixd
    nil
    uv

    # editors
    lite-xl
    vscode
    neovim

    # media
    ffmpegthumbnailer
    imagemagick
    pavucontrol
    pamixer
    ffmpeg
    yt-dlp
    cava
    mpv

    inputs.zen-browser.packages.${system}.default
    inputs.nix-alien.packages.${system}.nix-alien
    inputs.noctalia.packages.${system}.default
    inputs.copetch.packages.${system}.default
    inputs.helium.packages.${system}.default
    pkgs.qt6Packages.qtwebsockets
  ];
  environment.variables = {
    NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";
    PYTHONPATH = "${pythonEnv}/${pythonEnv.sitePackages}";
    GI_TYPELIB_PATH = "${pkgs.gtk4}/lib/girepository-1.0:${pkgs.libadwaita}/lib/girepository-1.0";
  };
}
