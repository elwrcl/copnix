{
  description = "copland, linux/darwin niximator";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    oceanix.url = "github:LEXUGE/oceanix";
    copetch.url = "github:elwrcl/copetch";
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
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
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
      nix-cachyos-kernel,
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
          {
            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.default
              (final: prev: {
                copetch = inputs.copetch.packages.${linuxSystem}.default;
              })
              (final: prev: {
                openldap = prev.openldap.overrideAttrs (old: {
                  doCheck = false;
                });
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
