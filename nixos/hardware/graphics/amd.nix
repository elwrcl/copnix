{ pkgs, ... }:

{
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
    rocmPackages.clr.icd
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];
}
