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
        config.useQuickCss = true;
        equibop = {
          enable = true;
          autoscroll.enable = true;
          settings = {
            discordBranch = "canary";
            customTitleBar = false;
            transparencyOption = "none";
            tray = true;
            minimizeToTray = true;
            autoStartMinimized = false;
            enableMenu = false;
            enableSplashScreen = true;
            hardwareAcceleration = true;
            hardwareVideoAcceleration = true;
            disableSmoothScroll = false;
            middleClickAutoscroll = true;
            enableTaskbarFlashing = false;
            arRPC = true;
            arRPCProcessScanning = true;
            spellCheckLanguages = [ "en-US" ];

            audio = {
              workaround = false;
              deviceSelect = true;
              granularSelect = true;
              ignoreVirtual = false;
              ignoreDevices = false;
              ignoreInputMedia = false;
              onlySpeakers = false;
              onlyDefaultSpeakers = true;
            };
          };
          state.firstLaunch = false;
        };
      };
    };
}
