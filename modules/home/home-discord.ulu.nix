{ ... }:
{
  flake.homeModules.home-discord =
    { inputs, ... }:
    {
      imports = [
        inputs.nixcord.homeModules.nixcord
      ];

      programs.nixcord = {
        enable = true;
        discord.silenceNoModClientWarning = true;
        legcord = {
          enable = true;
          settings = {
            channel = "canary";
            tray = "dynamic";
            minimizeToTray = true;
            mods = [ "shelter" ];
            doneSetup = true;
          };
        };
      };
    };
}
