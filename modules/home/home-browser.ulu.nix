{ ... }:
{
  flake.homeModules.home-browser-helium =
    { inputs, system, ... }:
    {
      imports = [ inputs.helium.homeModules.helium ];

      programs.helium = {
        enable = true;
        defaultBrowser = true;
        package = inputs.helium.packages.${system}.helium-widevine;

        extensions = [
          {
            id = "dkdnancajokhfclpjpplkhlkbhaeejob";
            hash = "sha256-hkEGW2JVQzeRmTpoPrWFoVG3sbCgHohnsr2b12rfeMg=";
          }
          {
            id = "jgejdcdoeeabklepnkdbglgccjpdgpmf";
            hash = "sha256-0xYJtbYNn0JwAaskB/qwdRt74ThSG1CcN41bTN4H88c=";
          }
          {
            id = "jleldmehlnopjhbldegndecakdemocah";
            hash = "sha256-u79qidIP1DCtusQ7COjjpnnInO/dXyBeNsJKNHnbIC4=";
          }
          {
            id = "kdbmhfkmnlmbkgbabkdealhhbfhlmmon";
            hash = "sha256-p+ifp+k4wwTlLQzwN5D5UTK+viMYBpreGfleXgwPeFc=";
          }
          {
            id = "knemcdpkggnbhpoaaagmjiigenifejfo";
            hash = "sha256-WjloJ6g17A70Met43snOrRFlZ7z46/PyOYbrjA7r89U=";
          }
          {
            id = "mmioliijnhnoblpgimnlajmefafdfilb";
            hash = "sha256-eLB9vM9jqyY+EMP1h8654m/6CJiRN0XymHF2Hcu6V1Y=";
          }
          {
            id = "oboonakemofpalcgghocfoadofidjkkk";
            hash = "sha256-wmkAetiDDZmncortFv/92K8Fm/zLfise0qAasQ4CKSU=";
          }
          {
            id = "oebdmlhbdidbibbidjpbndbloidnhmme";
            hash = "sha256-pTe61n2rQ4botE3UKpBupcND6LYUXTjjK//R3jINCLQ=";
          }
          {
            id = "omkfmpieigblcllmkgbflkikinpkodlk";
            hash = "sha256-pfYMvrk5PAgmeNrHndEchCiZbZDtGYxqCrKX4fz1Fow=";
          }
          {
            id = "ponfpcnoihfmfllpaingbgckeeldkhle";
            hash = "sha256-0vw3iCq/F5muPwn7Ny4g8LBkKrmSspaCtBo2ATxULeQ=";
          }
        ];

        extraPolicies = {
          MetricsReportingEnabled = false;
          HttpsOnlyMode = "force_enabled";
          DownloadDirectory = "/home/elars/Downloads";
        };

        preferences = {
          helium.browser = {
            layout = 2;
            zen_mode = true;
            zen_mode_sidebar_pinned = true;
            zen_mode_top_chrome_pinned = true;
            centered_location_bar = true;
            minimal_location_bar = true;
            rounded_frame = false;
            new_tab_next_to_active = false;
            vertical_right_aligned = false;
            show_back_button = true;
            show_extensions_button = true;
            show_media_button = true;
            show_menu_button = true;
            show_zoom_indicator = true;
            show_vertical_tabs_collapse_button = false;
          };
          helium.settings.a11y.copy_page_url_shortcut = true;

          vertical_tabs = {
            collapsed_state = true;
            uncollapsed_width = 200;
          };

          browser = {
            show_home_button = true;
            custom_chrome_frame = false;
            pin_split_tab_button = true;
            theme = {
              color_scheme2 = 0;
              follows_system_colors = false;
              is_grayscale2 = true;
            };
          };

          bookmark_bar = {
            show_on_all_tabs = true;
            show_tab_groups = false;
          };

          side_panel.is_right_aligned = false;

          webkit.webprefs = {
            default_font_size = 12;
            default_fixed_font_size = 9;
            fonts = {
              standard.Zyyy = "JetBrainsMono Nerd Font";
              serif.Zyyy = "JetBrainsMono Nerd Font";
              sansserif.Zyyy = "JetBrainsMono Nerd Font";
              fixed.Zyyy = "JetBrainsMono Nerd Font Mono";
            };
          };

          session.restore_on_startup = 5;
          homepage_is_newtabpage = true;

          https_only_mode_enabled = true;
          https_first_balanced_mode_enabled = false;
          privacy_sandbox.first_party_sets_enabled = false;

          intl.selected_languages = "en-US,en";
          savefile.default_directory = "/home/elars/Downloads";
          cpu_performance_tier_override = 2;
        };
      };
    };

  flake.homeModules.home-browser-zen =
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
