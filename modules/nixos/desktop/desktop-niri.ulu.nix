{ ... }:
{
  flake.nixosModules.desktop-niri =
    { pkgs, ... }:
    {
      programs.niri.enable = true;

      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];
    };
}
