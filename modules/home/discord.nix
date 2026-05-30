{
  inputs,
  ...
}:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    legcord = {
      enable = true;
      settings = {
        windowStyle = "default";
        channel = "canary";
        csp = "none";
        minimizeToTray = true;
        processScanning = true;
        scanInterval = 5000;
        overlayButtonColor = "#121214";
        audio = {
          workaround = false;
          deviceSelect = true;
          granularSelect = true;
          ignoreVirtual = false;
          ignoreDevices = false;
          ignoreInputMedia = false;
          onlySpeakers = false;
          onlyDefaultSpeakers = true;
          loopbackType = "loopback";
        };
        multiInstance = false;
        mods = [ ];
        transparency = "none";
        hardwareAcceleration = true;
        performanceMode = "performance";
        skipSplash = true;
        inviteWebsocket = true;
        startMinimized = false;
        disableHttpCache = false;
        customJsBundle = "https://legcord.app/placeholder.js";
        customCssBundle = "https://legcord.app/placeholder.css";
        disableAutogain = false;
        autoHideMenuBar = true;
        blockPowerSavingInVoiceChat = false;
        mobileMode = false;
        tray = "dsc-tray";
        doneSetup = true;
        popoutPiP = false;
        vaapi = true;
        spellcheck = true;
        spellcheckLanguage = [ "en-US" ];
        sleepInBackground = false;
        automaticUpdates = false;
        additionalArguments = "";
        smoothScroll = true;
        autoScroll = false;
        useSystemCssEditor = false;
        extendedPluginAbilities = false;
        quickCss = true;
        supportBannerDismissed = false;
      };
    };
  };
}
