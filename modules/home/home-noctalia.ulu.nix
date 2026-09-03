{ ... }:
{
  flake.homeModules.home-noctalia =
    {
      config,
      inputs,
      ...
    }:
    let
      home = config.home.homeDirectory;
      pictures = "${home}/Pictures";
    in
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;
        systemd.enable = false;

        settings = {
          accessibility = {
            high_contrast = true;
            ui_scale = 0.9;
          };

          audio = {
            enable_sounds = true;
            sound_volume = 0.0;
          };

          backdrop = {
            enabled = true;
            blur_intensity = 0.46;
            tint_intensity = 0.25;
          };

          brightness = {
            enable_ddcutil = false;
            minimum_brightness = 0.01;
          };

          nightlight = {
            enabled = true;
            temperature_day = 5200;
            temperature_night = 3300;
          };

          location.auto_locate = true;

          notification = {
            offset_y = 9;
            scale = 0.8;
          };

          osd = {
            position = "top_right";
            offset_x = 15;
            offset_y = 5;
            kinds.media = false;
          };

          dock = {
            auto_hide = true;
            icon_size = 37;
          };

          lockscreen.blurred_desktop = true;

          system.monitor = {
            cpu_temp_activity_threshold = 70;
            cpu_temp_critical_threshold = 80;
            cpu_usage_activity_threshold = 75;
          };

          idle = {
            behavior_order = [
              "lock"
              "screen-off"
              "lock-and-suspend"
            ];
            behavior = {
              lock = {
                action = "lock";
                enabled = true;
                timeout = 600;
              };
              lock-and-suspend = {
                action = "lock_and_suspend";
                enabled = false;
                timeout = 900;
              };
              screen-off = {
                action = "screen_off";
                enabled = false;
                timeout = 660;
              };
            };
          };

          shell = {
            app_icon_color = "on_hover";
            avatar_path = "${pictures}/noctalia/profile.png";
            corner_radius_scale = 0.0;
            font_family = "Hurmit Nerd Font";
            launch_apps_as_systemd_services = true;
            niri_overview_type_to_launch_enabled = true;
            password_style = "random";
            polkit_agent = true;
            screen_time_enabled = true;
            settings_show_advanced = true;
            ui_scale = 0.9;

            launcher = {
              categories = false;
              compact = true;
              show_icons = false;
            };

            panel = {
              launcher_categories = false;
              launcher_compact = true;
              launcher_show_icons = false;
              open_near_click_control_center = true;
              transparency_mode = "glass";
            };

            screen_corners.size = 1;
            screenshot.directory = "${pictures}/Screenshots";

            session.actions = [
              {
                action = "lock";
                enabled = true;
                shortcut = "1";
                variant = "default";
              }
              {
                action = "logout";
                enabled = true;
                shortcut = "2";
                variant = "default";
              }
              {
                action = "reboot";
                enabled = true;
                shortcut = "4";
                variant = "default";
              }
              {
                action = "shutdown";
                enabled = true;
                shortcut = "5";
                variant = "destructive";
              }
            ];

            shadow = {
              alpha = 0.0;
              direction = "up";
            };
          };

          theme = {
            builtin = "Ayu";
            community_palette = "Kemuri Susu";
            custom_palette = "nix-wallpaper-nineish-mo";
            mode = "light";
            source = "community";
            wallpaper_scheme = "m3-content";
            templates.community_ids = [ "telegram" ];
          };

          wallpaper = {
            directory = "${pictures}/nix-wall-binary";
            edge_smoothness = 0.61;
            fill_mode = "repeat";
            transition = [
              "disc"
              "fade"
              "honeycomb"
              "stripes"
              "wipe"
              "zoom"
            ];

            automation.enabled = true;
            default.path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-white.png";
            last.path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-white.png";

            monitors = {
              HDMI-A-1.path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-blue.png";
              LVDS-1.path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-white.png";
              VGA-1.path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-white.png";
            };

            favorite = [
              {
                community_palette = "Kemuri Susu";
                palette_source = "community";
                path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-blue.png";
                theme_mode = "dark";
              }
              {
                community_palette = "Kemuri Susu";
                palette_source = "community";
                path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-red.png";
                theme_mode = "dark";
              }
              {
                community_palette = "Kemuri Susu";
                palette_source = "community";
                path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-black.png";
                theme_mode = "dark";
              }
            ];
          };

          plugins.enabled = [
            "noctalia/screen_recorder"
            "noctalia/notes"
            "whyoolw/sharednd"
            "nightwatch75/todo"
            "avivbintangaringga/nix-monitor"
          ];

          plugin_settings = {
            "noctalia/mpvpaper" = {
              picker_open_near_click = true;
              picker_placement = "attached";
              picker_position = "center";
            };
            "noctalia/notes" = {
              panel_placement = "floating";
              panel_position = "top_right";
            };
            "noctalia/screen_recorder" = {
              audio_source = "both";
              color_range = "full";
              copy_to_clipboard = true;
              directory = "";
              quality = "ultra";
              replay_enabled = true;
              replay_filename_pattern = "replay_%Y%m%d_%H%M%S";
              resolution = "original";
            };
          };

          control_center = {
            calendar.show_events_card = false;
            shortcuts = [
              { type = "bluetooth"; }
              { type = "caffeine"; }
              { type = "nightlight"; }
              { type = "notification"; }
              { type = "power_profile"; }
              { type = "audio"; }
            ];
          };

          bar = {
            order = [ "copland" ];

            copland = {
              background_opacity = 0.0;
              border = "primary";
              capsule_foreground = "primary";
              capsule_padding = 4.0;
              capsule_radius = 0;
              capsule_thickness = 1.0;
              center = [
                "media"
                "clock"
                "active_window"
                "privacy"
              ];
              concave_edge_corners = false;
              end = [
                "tray"
                "group:g2"
                "control-center"
              ];
              font_family = "CaskaydiaCove Nerd Font";
              font_weight = 400;
              hover_highlight = false;
              margin_edge = 0;
              margin_ends = 0;
              padding = 2;
              panel_overlap = 0;
              radius = 0;
              scale = 1.1;
              shadow = false;
              start = [ "group:g4" ];
              widget_spacing = 10;

              capsule_group = [
                {
                  enabled = true;
                  fill = "surface_variant";
                  foreground = "primary";
                  id = "g1";
                  members = [
                    "ram"
                    "temp"
                    "sysmon"
                  ];
                  opacity = 0.0;
                  padding = 0.0;
                  radius = 0.0;
                }
                {
                  enabled = true;
                  fill = "surface_variant";
                  foreground = "primary";
                  id = "g2";
                  members = [
                    "nix-monitor"
                    "notifications"
                    "Killer"
                    "notes"
                    "recorder"
                  ];
                  opacity = 0.0;
                  padding = 0.0;
                  radius = 0.0;
                }
                {
                  enabled = true;
                  fill = "surface_variant";
                  foreground = "primary";
                  id = "g3";
                  members = [
                    "workspaces"
                    "spacer_4"
                    "cpu"
                  ];
                  opacity = 1.0;
                  padding = 0.0;
                  radius = 0.0;
                }
                {
                  border = "";
                  enabled = true;
                  fill = "primary";
                  id = "g4";
                  members = [
                    "workspaces"
                    "cpu"
                  ];
                  opacity = 0.0;
                  padding = 3.0;
                  radius = 0.0;
                }
              ];

              monitor.HDMI-A-1 = {
                end = [
                  "group:g2"
                  "spacer_3"
                  "tray"
                  "workspaces"
                  "control-center"
                ];
                position = "bottom";
                scale = 1.45;
                start = [ "group:g3" ];
                thickness = 40;

                capsule_group = [
                  {
                    enabled = true;
                    fill = "surface_variant";
                    foreground = "primary";
                    id = "g1";
                    members = [
                      "ram"
                      "temp"
                      "sysmon"
                    ];
                    opacity = 0.0;
                    padding = 0.0;
                    radius = 0.0;
                  }
                  {
                    enabled = false;
                    fill = "surface_variant";
                    foreground = "primary";
                    id = "g2";
                    members = [
                      "notifications"
                      "recorder"
                      "Killer"
                      "notes"
                      "nix-monitor"
                    ];
                    opacity = 0.0;
                    padding = 0.0;
                    radius = 0.0;
                  }
                  {
                    enabled = true;
                    fill = "surface_variant";
                    foreground = "primary";
                    id = "g3";
                    members = [
                      "sysmon"
                      "temp"
                      "ram"
                      "sysmon_4"
                      "sysmon_2"
                    ];
                    opacity = 0.0;
                    padding = 4.0;
                    radius = 0.0;
                  }
                ];
              };
            };
          };

          desktop_widgets = {
            schema_version = 2;
            widget_order = [
              "desktop-widget-0000000000000005"
              "desktop-widget-0000000000000001"
              "desktop-widget-0000000000000003"
              "desktop-widget-0000000000000004"
            ];

            grid = {
              cell_size = 8;
              major_interval = 4;
              visible = true;
            };

            widget = {
              desktop-widget-0000000000000001 = {
                box_height = 136.0;
                box_width = 208.0;
                cx = 107.06;
                cy = 688.0;
                output = "LVDS-1";
                rotation = 0.0;
                type = "sysmon";
                settings = {
                  background_opacity = 0.0;
                  background_radius = 11;
                  display = "graph";
                  gauge_layout = "horizontal";
                  shadow = true;
                  show_label = true;
                  stat = "cpu_usage";
                  stat2 = "cpu_temp";
                };
              };

              desktop-widget-0000000000000003 = {
                box_height = 136.0;
                box_width = 208.0;
                cx = 107.0;
                cy = 384.0;
                output = "LVDS-1";
                rotation = 0.0;
                type = "sysmon";
                settings = {
                  background = true;
                  background_opacity = 0.0;
                  background_radius = 11;
                  display = "graph";
                  gauge_layout = "horizontal";
                  shadow = true;
                  show_label = true;
                  stat = "ram_pct";
                  stat2 = "swap_pct";
                };
              };

              desktop-widget-0000000000000004 = {
                box_height = 136.0;
                box_width = 208.0;
                cx = 107.0;
                cy = 532.0;
                output = "LVDS-1";
                rotation = 0.0;
                type = "sysmon";
                settings = {
                  background_opacity = 0.0;
                  background_radius = 11;
                  display = "graph";
                  gauge_layout = "horizontal";
                  network_speed_compact = true;
                  network_speed_unit = "auto";
                  shadow = true;
                  show_label = true;
                  stat = "net_rx";
                  stat2 = "net_tx";
                };
              };

              desktop-widget-0000000000000005 = {
                box_height = 112.0;
                box_width = 1360.0;
                cx = 683.0;
                cy = 88.69;
                flip_y = true;
                output = "LVDS-1";
                rotation = 0.001;
                type = "audio_visualizer";
                settings = {
                  background = false;
                  bands = 128;
                  centered = false;
                  mirrored = true;
                  show_when_idle = true;
                };
              };
            };
          };

          lockscreen_widgets = {
            enabled = true;
            schema_version = 2;
            widget_order = [
              "lockscreen-login-box@HDMI-A-1"
              "lockscreen-login-box@VGA-1"
              "lockscreen-widget-0000000000000007"
              "lockscreen-login-box@LVDS-1"
              "lockscreen-widget-0000000000000003"
              "lockscreen-widget-0000000000000008"
              "lockscreen-widget-0000000000000009"
              "lockscreen-widget-000000000000000a"
              "lockscreen-widget-000000000000000b"
            ];

            grid = {
              cell_size = 8;
              major_interval = 4;
              visible = false;
            };

            widget = {
              "lockscreen-login-box@HDMI-A-1" = {
                box_height = 70.0;
                box_width = 400.0;
                cx = 968.0;
                cy = 1023.0;
                output = "HDMI-A-1";
                rotation = 0.0;
                type = "login_box";
                settings = {
                  background_color = "surface_variant";
                  background_opacity = 0.88;
                  background_radius = 12.0;
                  center_password_text = false;
                  input_opacity = 1.0;
                  input_radius = 6.0;
                  show_caps_lock = true;
                  show_keyboard_layout = true;
                  show_login_button = true;
                };
              };

              "lockscreen-login-box@LVDS-1" = {
                box_height = 70.0;
                box_width = 400.0;
                cx = 683.0;
                cy = 539.93;
                output = "LVDS-1";
                rotation = 0.0;
                type = "login_box";
                settings = {
                  center_password_text = false;
                  show_caps_lock = true;
                  show_keyboard_layout = true;
                  show_login_button = true;
                };
              };

              "lockscreen-login-box@VGA-1" = {
                box_height = 70.0;
                box_width = 400.0;
                cx = 512.0;
                cy = 645.0;
                output = "VGA-1";
                rotation = 0.0;
                type = "login_box";
                settings = {
                  background_color = "surface_variant";
                  background_opacity = 0.88;
                  background_radius = 12.0;
                  center_password_text = false;
                  input_opacity = 1.0;
                  input_radius = 6.0;
                  show_caps_lock = true;
                  show_keyboard_layout = true;
                  show_login_button = true;
                };
              };

              lockscreen-widget-0000000000000003 = {
                box_height = 123.68;
                box_width = 293.375;
                cx = 683.0;
                cy = 660.77;
                output = "LVDS-1";
                rotation = 0.0;
                type = "media_player";
                settings = {
                  background = true;
                  background_opacity = 1.0;
                  background_padding = 7.0;
                  background_radius = 16.0;
                  hide_when_no_media = true;
                  layout = "horizontal";
                  shadow = true;
                };
              };

              lockscreen-widget-0000000000000007 = {
                box_height = 135.26;
                box_width = 276.09;
                cx = 683.0;
                cy = 684.37;
                output = "LVDS-1";
                rotation = 0.0;
                type = "sysmon";
                settings = {
                  background = true;
                  background_opacity = 0.22;
                  background_padding = 6.0;
                  background_radius = 0.0;
                  font_family = "JetBrainsMono Nerd Font";
                  shadow = false;
                  show_label = true;
                  stat = "cpu_usage";
                  stat2 = "ram_pct";
                };
              };

              lockscreen-widget-0000000000000008 = {
                box_height = 0.0;
                box_width = 0.0;
                cx = 1271.0;
                cy = 106.0;
                output = "LVDS-1";
                rotation = 0.0;
                type = "sticker";
                settings = {
                  background_opacity = 0.0;
                  background_padding = 0.0;
                  background_radius = 0.0;
                  image_path = "${pictures}/noctalia/linux-tux.gif";
                  opacity = 1.0;
                };
              };

              lockscreen-widget-0000000000000009 = {
                box_height = 171.0;
                box_width = 520.0;
                cx = 960.0;
                cy = 105.5;
                output = "HDMI-A-1";
                rotation = 0.0;
                type = "clock";
                settings = {
                  background = false;
                  center_text = false;
                  clock_style = "digital";
                  font_family = "IPAexGothic";
                  shadow = false;
                };
              };

              lockscreen-widget-000000000000000a = {
                box_height = 84.0;
                box_width = 454.0;
                cx = 683.0;
                cy = 172.0;
                output = "LVDS-1";
                rotation = 0.0;
                type = "clock";
                settings = {
                  background = false;
                  center_text = false;
                  clock_style = "digital";
                  font_family = "IPAexGothic";
                  shadow = false;
                };
              };

              lockscreen-widget-000000000000000b = {
                box_height = 109.4;
                box_width = 179.0;
                cx = 960.0;
                cy = 917.3;
                output = "HDMI-A-1";
                rotation = 0.0;
                type = "weather";
              };
            };
          };

          widget = {
            Killer = {
              glyph = "device-desktop-filled";
              scale = 1.1;
              tooltip = "kill tv";
              type = "custom_button";
              actions = {
                left = "exec niri msg output HDMI-A-1 off";
                right = "exec niri msg output HDMI-A-1 on";
              };
            };

            active_window = {
              display = "text_only";
              font_family = "Hurmit Nerd Font";
              font_weight = 400;
              icon_size = 8.0;
              max_length = 160;
              min_length = 273;
              scale = 0.95;
              title_scroll = "always";
            };

            bongocat = {
              script = "scripts/bongocat.lua";
              type = "scripted";
            };

            cat.type = "noctalia/bongocat:cat";

            clock = {
              anchor = true;
              capsule_fill = "shadow";
              capsule_padding = 8;
              color = "primary";
              font_family = "Hurmit Nerd Font";
              font_weight = 700;
            };

            control-center = {
              capsule_fill = "shadow";
              capsule_opacity = 0.0;
              capsule_padding = 2;
              capsule_radius = "auto";
              color = "primary";
              custom_image = "${pictures}/noctalia/nixos.svg";
              custom_image_colorize = true;
              scale = 1.25;
            };

            cpu = {
              capsule_padding = 12;
              capsule_radius = "auto";
              color = "primary";
              display = "graph";
              glyph = "contrast-2-filled";
              icon_color = "primary";
              scale = 1.3;
              show_label = false;
              show_value = false;
              visualization = "graph";
            };

            custom_button_2.type = "custom_button";

            launcher.glyph = "box";

            media = {
              art_size = 20.0;
              capsule_opacity = 0.31;
              capsule_padding = 7.0;
              font_family = "Hurmit Nerd Font";
              font_weight = 400;
              hide_album_art = true;
              hide_when_no_media = true;
              max_length = 160;
              scale = 0.95;
              title_scroll = "always";
            };

            mpvpaper.type = "noctalia/mpvpaper:mpvpaper";

            nix-monitor = {
              capsule_opacity = 0.28;
              capsule_padding = 0;
              checking_glyph = "loader";
              scale = 1.2;
              show_text = false;
              type = "avivbintangaringga/nix-monitor:nix-monitor";
              update_available_glyph = "cloud-down";
            };

            notes = {
              glyph = "note";
              scale = 1.2;
              type = "noctalia/notes:notes";
            };

            notifications = {
              hide_when_no_unread = true;
              scale = 1.1;
            };

            privacy = {
              font_weight = 700;
              hide_inactive = true;
              icon_color = "primary";
              icon_spacing = 0;
            };

            ram.show_glyph = false;

            recorder = {
              icon_color = "error";
              scale = 1.2;
              type = "noctalia/screen_recorder:recorder";
            };

            screen_recorder = {
              audio_codec = "aac";
              audio_source = "both";
              color_range = "full";
              copy_to_clipboard = true;
              quality = "ultra";
              script = "scripts/screen_recorder.lua";
              type = "scripted";
            };

            scripted_2.type = "scripted";

            spacer_2 = {
              length = 195;
              type = "spacer";
            };

            spacer_3 = {
              length = 31;
              type = "spacer";
            };

            spacer_4 = {
              length = 6;
              type = "spacer";
            };

            sysmon = {
              show_glyph = false;
              show_value = true;
              visualization = "none";
            };

            sysmon_2 = {
              show_glyph = false;
              stat = "disk_used_pct";
              type = "sysmon";
            };

            sysmon_4 = {
              glyph = "box-padding";
              show_glyph = false;
              show_value = true;
              stat = "swap_pct";
              type = "sysmon";
              visualization = "none";
            };

            temp = {
              display = "text";
              show_glyph = false;
              show_label = false;
            };

            tray = {
              capsule_opacity = 0.0;
              capsule_padding = 0;
              capsule_radius = 0;
              color = "primary";
              drawer = true;
              drawer_columns = 4;
              drawer_item_size = 23.0;
              match_adjacent_spacing = true;
              pinned = [
                "equibop"
                "TelegramDesktop"
                "Legcord"
                "Discord"
                "steam"
              ];
            };

            weather.show_condition = false;

            workspaces = {
              active_pill_size = 2.05;
              capsule_border = "shadow";
              capsule_fill = "shadow";
              capsule_foreground = "shadow";
              capsule_opacity = 0.24;
              capsule_padding = 0;
              capsule_radius = "auto";
              empty_color = "error";
              focused_color = "surface_variant";
              font_weight = 700;
              inactive_pill_size = 0.25;
              label_source = "name";
              labels_only_when_occupied = true;
              occupied_color = "primary";
              pill_scale = 0.85;
              scale = 1.65;
              style = "focus_hint";
            };
          };
        };
      };
    };
}
