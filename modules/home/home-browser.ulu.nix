{ ... }:
{
  flake.homeModules.home-browser =
    { inputs, lib, ... }:
    let
      mkExtension = id: {
        install_url =
          let
            slug = builtins.replaceStrings [ "{" "}" ] [ "%7B" "%7D" ] id;
          in
          "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
        installation_mode = "normal_installed";
      };
    in
    {
      imports = [ inputs.zen-browser.homeModules.beta ];

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;

        policies = {
          DisableAppUpdate = true;
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableFirefoxAccounts = false;
          OfferToSaveLogins = false;
          ExtensionSettings = lib.genAttrs [
            "uBlock0@raymondhill.net"
            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}"
            "{dc422521-1e6f-4998-ada8-25d61135e8ad}"
            "enhancerforyoutube@maximerf.addons.mozilla.org"
            "Librezam@Librezam"
            "autofxtwitter@itsrqtl"
            "oldtwitter@dimden.dev-reupload"
            "claude-toolbox@lugia19.com"
            "claude_usage_tracker@lugia19.com"
            "firefox-extension@steamdb.info"
            "chrome-mask@overengineer.dev"
            "{a4cc20af-d30a-4758-a799-2089ce45f452}"
            "plasma-browser-integration@kde.org"
          ] mkExtension;
        };
        profiles.Yamura = {
          id = 0;
          path = "92k4064j.Yamura";
          isDefault = true;
          settings = {
            "zen.urlbar.behavior" = "float";
            "zen.view.compact.enable-at-startup" = true;
            "zen.view.use-single-toolbar" = false;
            "zen.glance.enabled" = false;
            "zen.tabs.select-recently-used-on-close" = false;
            "zen.theme.content-element-separation" = 5;
            "zen.workspaces.show-workspace-indicator" = true;
            "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
            "signon.rememberSignons" = false;
          };

          mods = [
            "906c6915-5677-48ff-9bfc-096a02a72379"
            "f4866f39-cfd6-4498-ab92-54213b8279dc"
            "6cd4bca9-f17d-4461-b554-844d69a4887c"
            "2317fd93-c3ed-4f37-b55a-304c1816819e"
            "1e9f3101-210b-4ff5-8830-434e4919100d"
            "b0f635d7-c3bf-4709-af68-4712f0e5b2e5"
            "72f8f48d-86b9-4487-acea-eb4977b18f21"
            "f7c71d9a-bce2-420f-ae44-a64bd92975ab"
            "c6813222-6571-4ba6-8faf-58f3343324f6"
          ];
          keyboardShortcutsVersion = 20;
          keyboardShortcuts = [
            {
              id = "key_undoCloseWindow";
              disabled = true;
            }
            {
              id = "key_toggleReaderMode";
              disabled = true;
            }
            {
              id = "key_exitFullScreen";
              disabled = true;
            }
            {
              id = "key_duplicateTab";
              disabled = true;
            }
          ];
        };
      };
    };
}
