{ config, lib, pkgs, ... }:

let
  driver = config.elars.hardware.graphics.driver;
in
{
  options.elars.hardware.graphics.driver = lib.mkOption {
    type = lib.types.enum [ "intel" "amd" "nvidia" "hybrid-amd-nvidia" ];
    default = "intel";
  };

  config = lib.mkMerge [
    {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    }

    (lib.mkIf (driver == "intel") (import ./intel.nix { inherit config lib pkgs; }))
    (lib.mkIf (driver == "amd") (import ./amd.nix { inherit config lib pkgs; }))
    (lib.mkIf (driver == "nvidia") (import ./nvidia.nix { inherit config lib pkgs; }))
    (lib.mkIf (driver == "hybrid-amd-nvidia") (lib.mkMerge [
      (import ./amd.nix { inherit config lib pkgs; })
      (import ./nvidia.nix { inherit config lib pkgs; })
      (import ./prime.nix { inherit config lib pkgs; })
    ]))
  ];
}
