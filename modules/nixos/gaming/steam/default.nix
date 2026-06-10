{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = [
      "--rt"
    ];
    env = {
      INTEL_DEBUG = "noccs";
    };
  };

  hardware.steam-hardware.enable = true;
}
