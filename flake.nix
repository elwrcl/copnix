{
  description = "copland, linux/darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    copetch = {
      url = "github:elwrcl/copetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    soryu-kernel = {
      url = "github:elwrcl/soryu-kernel";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
    };
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-cachyos-kernel,
      chaotic,
      niri,
      ...
    }:
    let
      linuxSystem = "x86_64-linux";
      darwinSystem = "x86_64-darwin";
    in
    {
      nixosConfigurations.copland = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          system = linuxSystem;
        };
        modules = [
          { nixpkgs.hostPlatform = linuxSystem; }
          home-manager.nixosModules.home-manager
          chaotic.nixosModules.default
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [ inputs.niri.homeModules.niri ];
              extraSpecialArgs = {
                inherit inputs;
                system = linuxSystem;
              };
              users.elars = import ./main/nixos/home.nix;
            };
          }
          ./main/nixos/machine.nix
        ];
      };

      darwinConfigurations.sohryu-darwin = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
          system = darwinSystem;
        };
        modules = [
          home-manager.darwinModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.config.allowDeprecatedx86_64Darwin = true;
            nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
                system = darwinSystem;
              };
              users.sohryu = import ./main/darwin/home.nix;
            };
          }
          ./main/darwin/machine.nix
        ];
      };
    };
}
