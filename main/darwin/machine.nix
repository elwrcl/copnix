{ pkgs, system, ... }:

let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ../../modules/darwin
  ];

  networking.hostName = "sohryu-darwin";
  networking.computerName = "sohryu-darwin";

  nixpkgs.hostPlatform = system;

  system.stateVersion = 5;
  system.primaryUser = "sohryu";

  environment.systemPackages = packages.system;
}
