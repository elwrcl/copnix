{ ... }:
{
  flake.nixosModules.desktop-niri =
    { pkgs, ... }:
    {
      programs.niri.enable = true;
      nixpkgs.overlays = [
        (final: prev: {
          xwayland-satellite = prev.xwayland-satellite.overrideAttrs (old: {
            patches = (old.patches or [ ]) ++ [
              (final.fetchpatch {
                name = "no-focus-for-override-redirect-popups.patch";
                url = "https://github.com/Supreeeme/xwayland-satellite/pull/494.diff";
                hash = "sha256-X7v6rAyTGE0e1UIbhL7XoYx5puZ0C9b+YAwIgT4Gyzk=";
              })
            ];
          });
        })
      ];

      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];
    };
}
