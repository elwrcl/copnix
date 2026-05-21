{
  pkgs,
  ...
}:

let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ./hardware.nix
    ./nixos
  ];

  elars.hardware.graphics.driver = "intel";

  zramSwap = {
    enable = true;
    memoryPercent = 100;
    algorithm = "zstd";
    priority = 100;
  };
  environment.systemPackages = packages.system;
  environment.pathsToLink = [
    "/share/applications"
    "/share/icons"
    "/share/mime"
  ];
}
