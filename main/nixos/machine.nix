{
  pkgs,
  inputs,
  system,
  ...
}:

let
  packages = import ./packages.nix { inherit pkgs inputs system; };
in
{
  imports = [
    ./hardware.nix
    ../../modules/nixos
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
    "/share/X11"
  ];
}
