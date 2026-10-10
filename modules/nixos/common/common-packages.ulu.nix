{ ... }:
{
  flake.nixosModules.common-packages =
    {
      pkgs,
      inputs,
      system,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        # apps
        onlyoffice-desktopeditors
        telegram-desktop
        prismlauncher
        gparted-full
        moonlight-qt
        qbittorrent
        obs-studio
        spotifast
        picotool
        sunshine
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
        playerctl
        wf-recorder
        tesseract
        mpvpaper
        swappy
        slurp
        grim
        wev

        # phone
        libimobiledevice
        android-tools
        usbmuxd
        libmtp
        scrcpy
        ifuse

        # agents
        github-copilot-cli
        claude-code

        # cli
        fastfetch
        tailscale
        trash-cli
        dos2unix
        jujutsu
        autossh
        ani-cli
        cachix
        lazyjj
        direnv
        jj-fzf
        zoxide
        rsync
        unzip
        tree
        meld
        tldr
        perf
        file
        wget
        htop
        tmux
        btop
        yazi
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
        dmidecode
        libsecret
        gptfdisk
        pciutils
        usbutils
        hfsprogs
        dmg2img
        clinfo
        hidapi
        parted
        p7zip
        xar

        # themes/icons
        gnome-themes-extra

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
        sqlite
        aubio
        delta
        trunk
        nixd
        nil
        uv

        # editors
        neovim

        # media
        ffmpegthumbnailer
        imagemagick
        pavucontrol
        pamixer
        ffmpeg
        yt-dlp
        cava

        inputs.agenix.packages.${system}.default
        inputs.nix-alien.packages.${system}.nix-alien
        pkgs.qt6Packages.qtwebsockets
      ];
    };
}
