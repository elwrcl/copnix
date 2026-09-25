{ ... }:
{
  flake.nixosModules.desktop-niri =
    { pkgs, ... }:
    {
      programs.niri.enable = true;
      nixpkgs.overlays = [
        (final: prev: {
          xwayland-satellite =
            if prev.lib.versionOlder prev.xwayland-satellite.version "0.8.3" then
              prev.xwayland-satellite.overrideAttrs (old: {
                patches = (old.patches or [ ]) ++ [
                  ./xwayland-satellite-no-focus-override-redirect.patch
                ];
              })
            else
              prev.xwayland-satellite;
        })
      ];

      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];
    };
}
