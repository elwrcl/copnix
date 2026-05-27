{
  description = "copland, linux/darwin niximator";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nyx-loner = {
      url = "github:lonerOrz/nyx-loner";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
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
    hyprland.url = "github:hyprwm/Hyprland";
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
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nyx-loner,
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
          nyx-loner.nixosModules.default
          {
            nixpkgs.overlays = [
              (final: prev: {
                copetch = inputs.copetch.packages.${linuxSystem}.default;
              })
            ];
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
                system = linuxSystem;
              };
              users.elars = import ./home/linux.nix;
            };
          }
          ./machine.nix
          ./nixos/default.nix
        ];
      };

      darwinConfigurations.copland = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
          system = darwinSystem;
        };
        modules = [
          home-manager.darwinModules.home-manager
          {
            nixpkgs.hostPlatform = darwinSystem;
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
                system = darwinSystem;
              };
              users.elars = import ./home/darwin.nix;
            };
          }
          ./darwin/default.nix
        ];
      };
    };
}
