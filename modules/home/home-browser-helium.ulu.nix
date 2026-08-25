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
          }
          {
            id = "jgejdcdoeeabklepnkdbglgccjpdgpmf";
          }
          {
            id = "jleldmehlnopjhbldegndecakdemocah";
          }
          {
            id = "kdbmhfkmnlmbkgbabkdealhhbfhlmmon";
          }
          {
            id = "knemcdpkggnbhpoaaagmjiigenifejfo";
          }
          {
            id = "mmioliijnhnoblpgimnlajmefafdfilb";
          }
          {
            id = "oboonakemofpalcgghocfoadofidjkkk";
          }
          {
            id = "oebdmlhbdidbibbidjpbndbloidnhmme";
          }
          {
            id = "omkfmpieigblcllmkgbflkikinpkodlk";
          }
          {
            id = "ponfpcnoihfmfllpaingbgckeeldkhle";
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
            minimal_location_bar = false;
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