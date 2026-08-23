{ config, inputs, ... }:
let
  system = "x86_64-linux";
in
{
  flake.nixosConfigurations.copland = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs system;
    };

    modules = [
      { nixpkgs.hostPlatform = system; }

      inputs.home-manager.nixosModules.home-manager
      inputs.chaotic.nixosModules.default

      {
        nixpkgs.config.allowUnfree = true;
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-bak";
          sharedModules = [ inputs.niri.homeModules.niri ];
          extraSpecialArgs = {
            inherit inputs system;
          };
          users.elars = {
            imports = [
              config.flake.homeModules.home-base
              config.flake.homeModules.home-ghostty
              config.flake.homeModules.home-nushell
              config.flake.homeModules.home-nushell-bash-compat
              config.flake.homeModules.home-nushell-colors
              config.flake.homeModules.home-nushell-completions
              config.flake.homeModules.home-nushell-prompt
              config.flake.homeModules.home-nushell-commandline-copy
              config.flake.homeModules.home-nushell-keybinds
              config.flake.homeModules.home-nushell-last
              config.flake.homeModules.home-nushell-editor
              config.flake.homeModules.home-helix
              config.flake.homeModules.home-helix-theme
              config.flake.homeModules.home-helix-keys
              config.flake.homeModules.home-helix-languages
              config.flake.homeModules.home-helix-language-servers
              config.flake.homeModules.home-zellij
              config.flake.homeModules.home-zellij-keybinds
              config.flake.homeModules.home-zellij-theme
              config.flake.homeModules.home-zellij-layout-ide
              config.flake.homeModules.home-zellij-ide-command
              config.flake.homeModules.home-direnv
              config.flake.homeModules.home-jujutsu
              config.flake.homeModules.home-jujutsu-difftastic
              config.flake.homeModules.home-jujutsu-mergiraf
              config.flake.homeModules.home-jujutsu-watchman
              config.flake.homeModules.home-gh
              config.flake.homeModules.home-radicle
              config.flake.homeModules.home-zsh
              config.flake.homeModules.home-shell-tools
              config.flake.homeModules.home-session-vars
              config.flake.homeModules.home-cursor
              config.flake.homeModules.home-gtk
              config.flake.homeModules.home-qt
              config.flake.homeModules.home-browser
              config.flake.homeModules.home-mimeapps
              config.flake.homeModules.home-file-manager
              config.flake.homeModules.home-file-manager-actions
              config.flake.homeModules.home-easyeffects
              config.flake.homeModules.home-nyi
              config.flake.homeModules.home-discord
              config.flake.homeModules.home-noctalia
              config.flake.homeModules.desktop-niri-home
              config.flake.homeModules.desktop-niri-package
              config.flake.homeModules.desktop-niri-env
              config.flake.homeModules.desktop-niri-execs
              config.flake.homeModules.desktop-niri-general
              config.flake.homeModules.desktop-niri-keybinds
              config.flake.homeModules.desktop-niri-rules
            ];
            home.username = "elars";
            home.homeDirectory = "/home/elars";
            home.stateVersion = "25.05";
          };
        };
      }

      config.flake.nixosModules.hostname-assert
      { elars.expectedHostName = "copland"; }
      # pool
      config.flake.nixosModules.common-boot
      config.flake.nixosModules.hw-bluetooth
      config.flake.nixosModules.hw-graphics
      config.flake.nixosModules.hw-intel-hard
      config.flake.nixosModules.hw-udev
      config.flake.nixosModules.net-network-manager
      config.flake.nixosModules.net-dpi-evasion
      config.flake.nixosModules.service-appimage
      config.flake.nixosModules.service-flatpak
      config.flake.nixosModules.service-fwupd
      config.flake.nixosModules.service-kde-connect
      config.flake.nixosModules.service-ollama
      config.flake.nixosModules.service-performance
      config.flake.nixosModules.service-printing
      config.flake.nixosModules.service-security
      config.flake.nixosModules.service-ssh
      config.flake.nixosModules.service-tumbler
      config.flake.nixosModules.service-xfconf
      config.flake.nixosModules.common-locale
      config.flake.nixosModules.common-nix
      config.flake.nixosModules.common-nix-access-tokens
      config.flake.nixosModules.common-fonts
      config.flake.nixosModules.common-kmscon
      config.flake.nixosModules.desktop-display
      config.flake.nixosModules.desktop-audio
      config.flake.nixosModules.desktop-niri
      config.flake.nixosModules.desktop-xdg-mime
      config.flake.nixosModules.gaming-steam
      config.flake.nixosModules.gaming-gamemode
      config.flake.nixosModules.common-users
      config.flake.nixosModules.service-docker
      config.flake.nixosModules.service-virt-manager
      config.flake.nixosModules.common-git
      config.flake.nixosModules.common-agenix
      config.flake.nixosModules.common-packages
      # import
      ./copland-hardware.nix
      {
        elars.hardware.graphics.driver = "intel";

        zramSwap = {
          enable = true;
          memoryPercent = 100;
          algorithm = "zstd";
          priority = 100;
        };

        environment.pathsToLink = [
          "/share/applications"
          "/share/icons"
          "/share/mime"
          "/share/X11"
        ];

        age.secrets.radicle-key = {
          file = ../modules/nixos/common/secrets/radicle.age;
          owner = "elars";
        };
      }
    ];
  };
}
