{ ... }:
{
  flake.nixosModules.desktop-niri =
    { pkgs, ... }:
    {
      programs.niri.enable = true;
      nixpkgs.overlays = [
        (final: prev: {
          xwayland-satellite = prev.xwayland-satellite.overrideAttrs (old: {
            patches =
              (old.patches or [ ])
              ++ prev.lib.optional (prev.lib.versionOlder old.version "0.8.3") ./xwayland-satellite-no-focus-override-redirect.patch
              ++ prev.lib.optional (prev.lib.versionOlder old.version "0.8.4") ./xwayland-satellite-resizable-dialog-toplevel.patch;
          });
        })
      ];

      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];
    };
}
