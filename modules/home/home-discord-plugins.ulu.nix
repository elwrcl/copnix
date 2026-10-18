{ ... }:
{
  flake.homeModules.home-discord-plugins =
    { ... }:
    {
      programs.nixcord.config = {
        frameless = true;
        transparent = true;
        disableMinSize = true;

        plugins = {
          betterSettings.enable = true;
          blurNsfw.enable = true;
          callTimer.enable = true;
          crashHandler.enable = true;
          customFolderIcons = {
            enable = true;
            solidIcon = true;
          };
          declutter = {
            enable = true;
            alwaysShowUsername = false;
            removeAudioMenus = false;
            removeClanTag = false;
            removeNameplate = false;
          };
          equibopStreamFixes.enable = true;
          equicordHelper.enable = true;
          fakeNitro.enable = true;
          fakeProfileThemes.enable = true;
          fixSpotifyEmbeds = {
            enable = true;
            volume = 10.0;
          };
          fixYoutubeEmbeds.enable = true;
          gifCollections.enable = true;
          messageLinkEmbeds.enable = true;
          messageLogger = {
            enable = true;
            ignoreBots = false;
          };
          messageLoggerEnhanced.enable = true;
          newPluginsManager.enable = true;
          noF1.enable = true;
          noNitroUpsell.enable = true;
          noTrack.enable = true;
          notificationVolume = {
            enable = true;
            notificationVolume = 50.0;
          };
          secretRingToneEnabler = {
            enable = true;
            onlySnow = true;
          };
          serverInfo.enable = true;
          settings.enable = true;
          shikiCodeblocks = {
            enable = true;
            bgOpacity = 100.0;
          };
          showHiddenThings.enable = true;
          showTimeoutDuration.enable = true;
          spotifyCrack.enable = true;
          streamingCodecDisabler = {
            enable = true;
            disableAv1Codec = true;
            disableVp8Codec = true;
            disableVp9Codec = true;
          };
          supportHelper.enable = true;
          unsuppressEmbeds.enable = true;
          volumeBooster = {
            enable = true;
            multiplier = 2.0;
          };
          whosWatching.enable = true;
          youtubeAdblock.enable = true;
        };
      };
    };
}
