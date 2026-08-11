{ ... }:
{
  flake.nixosModules.common-packages =
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
    {
      environment.systemPackages = with pkgs; [
        # apps
        onlyoffice-desktopeditors
        telegram-desktop
        prismlauncher
        moonlight-qt
        qbittorrent
        obs-studio
        localsend
        picotool
        sunshine
        # todo find better spotify client
        spotify
        whatsie
        heroic
        loupe
        gimp
        wine

        # file-manager
        # todo change file manager
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
        nautilus

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
        simple-mtpfs
        usbmuxd
        libmtp
        scrcpy
        ifuse

        # agents
        # todo make claude lobotomize
        github-copilot-cli
        claude-mergetool
        claude-monitor
        claude-code

        # cli
        agenix-cli
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
        kitty
        tree
        meld
        tldr
        perf
        file
        wget
        fish
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
        apfs-fuse
        gptfdisk
        pciutils
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
        neovim
        vscode

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
        inputs.copetch.packages.${system}.default
        inputs.helium.packages.${system}.default
        pkgs.qt6Packages.qtwebsockets
      ];
    };
}
