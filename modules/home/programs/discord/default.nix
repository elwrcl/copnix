{ inputs, ... }:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    legcord = {
      enable = true;
      settings = {
        channel = "stable";
        tray = "dynamic";
        minimizeToTray = true;
        mods = [ "shelter" ];
        doneSetup = true;
      };
    };
  };
}
