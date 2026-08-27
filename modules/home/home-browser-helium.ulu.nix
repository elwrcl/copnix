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
}