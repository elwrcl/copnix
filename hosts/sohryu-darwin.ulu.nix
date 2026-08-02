{ config, inputs, ... }:
let
  system = "x86_64-darwin";
in
{
  flake.darwinConfigurations.sohryu-darwin = inputs.nix-darwin.lib.darwinSystem {
    specialArgs = {
      inherit inputs system;
    };

    modules = [
      { nixpkgs.hostPlatform = system; }

      inputs.home-manager.darwinModules.home-manager

      {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.config.allowDeprecatedx86_64Darwin = true;
        nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit inputs system;
          };
          users.sohryu = {
            imports = [
              config.flake.homeModules.home-base
              config.flake.homeModules.home-ghostty
              config.flake.homeModules.home-nushell
              config.flake.homeModules.home-nushell-colors
              config.flake.homeModules.home-nushell-completions
              config.flake.homeModules.home-nushell-prompt
              config.flake.homeModules.home-nushell-commandline-copy
              config.flake.homeModules.home-nushell-last
              config.flake.homeModules.home-direnv
              config.flake.homeModules.home-jujutsu
              config.flake.homeModules.home-jujutsu-difftastic
              config.flake.homeModules.home-jujutsu-mergiraf
              config.flake.homeModules.home-jujutsu-watchman
              config.flake.homeModules.home-gh
              config.flake.homeModules.home-radicle
            ];
            home.username = "sohryu";
            home.homeDirectory = "/Users/sohryu";
            home.stateVersion = "25.05";
          };
        };
      }

      config.flake.darwinModules.hostname-assert
      { elars.expectedHostName = "sohryu-darwin"; }
      # pool
      config.flake.darwinModules.common-git
      config.flake.darwinModules.common-homebrew
      config.flake.darwinModules.common-system
      config.flake.darwinModules.common-user
      config.flake.darwinModules.common-packages

      # import

      {
        networking.hostName = "sohryu-darwin";
        networking.computerName = "sohryu-darwin";
        system.stateVersion = 5;
      }
    ];
  };
}
