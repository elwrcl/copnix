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
            doneSetup = true;
            mods = [ "shelter" ];
            noBundleUpdates = [ ];
            automaticUpdates = false;
            windowStyle = "native";
            windowMaterial = "mica";
            transparency = "none";
            tray = "dsc-tray";
            minimizeToTray = true;
            startMinimized = "off";
            autoHideMenuBar = true;
            skipSplash = true;
            multiInstance = false;
            mobileMode = false;
            popoutPiP = true;
            overlayButtonColor = "#121214";
            hardwareAcceleration = true;
            vaapi = true;
            performanceMode = "performance";
            sdpH264BaselineRewrite = true;
            smoothScroll = true;
            autoScroll = true;
            sleepInBackground = false;
            blockPowerSavingInVoiceChat = false;
            disableHttpCache = false;
            disableAutogain = false;

            audio = {
              workaround = false;
              deviceSelect = true;
              granularSelect = true;
              ignoreVirtual = false;
              ignoreDevices = false;
              ignoreInputMedia = false;
              onlySpeakers = false;
              onlyDefaultSpeakers = true;
              loopbackType = "loopbackWithMute";
            };

            processScanning = true;
            windowsLegacyScanning = false;
            scanInterval = 5000;
            inviteWebsocket = false;
            spellcheck = true;
            spellcheckLanguage = [ "en-US" ];
            quickCss = true;
            useSystemCssEditor = false;
            csp = "none";
            extendedPluginAbilities = false;
            showExperimentalPluginMenu = false;
            proxyMode = "system";
            proxyRules = "";
            proxyBypassRules = "<local>";
            proxyPacScript = "";
            keybinds = [ ];
            bounceOnPing = false;
            useMacSystemPicker = false;
            additionalArguments = "";
            supportBannerDismissed = true;
          };
        };
      };
    };
}
