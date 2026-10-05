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
        max-jobs = 2;
        cores = 0;

        min-free = 5368709120; # 5 GiB
        max-free = 21474836480; # 20 GiB

        substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
          "https://ezkea.cachix.org"
          "https://noctalia.cachix.org"
          "https://hyprland.cachix.org"
          "https://attic.xuyh0120.win/lantian"
          "https://soryu-kernel.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
          "soryu-kernel.cachix.org-1:2/Tm90ibGjLQWo/uX4qo/kbFB5yjQG/CzfE1oelHdWw="
        ];
      };

      nix.gc = {
        automatic = true;
        dates = "Mon 03:00";
        options = "--delete-older-than 14d";
        persistent = true;
        randomizedDelaySec = "45min";
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
