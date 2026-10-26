{
  description = "copland, linux dendritic flake";

  nixConfig = {
    experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];

    builders-use-substitutes = true;
    http-connections = 50;
    show-trace = true;
    warn-dirty = false;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:elwrcl/heliux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sidechery = {
      url = "github:teidesu/sidechery";
      flake = false;
    };
    theme-assets = {
      url = "github:elwrcl/copland-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    themes = {
      url = "github:RGBCube/ThemeNix";
    };
    intel-hard = {
      url = "github:elwrcl/intel-hard";
    };
    ivb-drivers = {
      # remote "github:elwrcl/ivybridge-drivers"
      url = "git+file:///mnt/HDD/linuxdata/Projects_XFS/Drivers/ivb-drivers-bin";
      flake = false;
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # own nixpkgs on purpose: the `cachix` branch is what noctalia's cache builds
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/cachix";
    };
    nyi = {
      url = "github:elwrcl/nyi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scx_soryu = {
      url = "github:elwrcl/scx_soryu";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    valw = {
      url = "github:elwrcl/valw";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { lib, ... }:
      let
        inherit (lib.filesystem) listFilesRecursive;
        inherit (lib.lists) filter;
        inherit (lib.strings) hasSuffix;
      in
      {
        systems = [ "x86_64-linux" ];
        imports = filter (hasSuffix ".ulu.nix") (listFilesRecursive ./.);
      }
    );
}
