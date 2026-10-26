{ ... }:
{
  flake.nixosModules.common-nix =
    { ... }:
    {
      nix.settings = {
        trusted-users = [
          "root"
          "elars"
        ];
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        max-jobs = 4;
        cores = 0;

        min-free = 5368709120; # 5 GiB
        max-free = 21474836480; # 20 GiB

        substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
          "https://noctalia.cachix.org"
          "https://soryu-kernel.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          "soryu-kernel.cachix.org-1:2/Tm90ibGjLQWo/uX4qo/kbFB5yjQG/CzfE1oelHdWw="
        ];
      };

      documentation = {
        man.enable = true;
        doc.enable = false;
        info.enable = false;
        nixos.enable = false;
      };

      programs.nix-ld.enable = true;
    };
}
