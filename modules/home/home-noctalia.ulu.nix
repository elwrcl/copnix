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
            high_contrast = false;
            ui_scale = 0.9;
          };
          audio = {
            enable_sounds = true;
            sound_volume = 0.0;
          };
          backdrop = {
            blur_intensity = 0.46;
            enabled = false;
            tint_intensity = 0.25;
          };
          bar = {
            order = [
              "copland"
            ];
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
              font_family = "Hurmit Nerd Font";
              font_weight = 400;
              hover_highlight = false;
              margin_edge = 0;
              margin_ends = 0;
              padding = 2;
              panel_overlap = 0;
              radius = 0;
              scale = 1.1;
              shadow = false;
              start = [
                "group:g4"
              ];
              widget_spacing = 10;
              monitor = {
                HDMI-A-1 = {
                  end = [
                    "bar"
                    "recorder_2"
                    "group:g2"
                    "tray"
                    "workspaces"
                    "control-center"
                  ];
                  position = "bottom";
                  scale = 1.45;
                  start = [
                    "group:g3"
                  ];
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
                        "valw"
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
                    "valw"
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
            };
          };
          battery = {
            device = {
              "/org/freedesktop/UPower/devices/phone_dev_D0_D2_B0_4E_4E_43" = {
                warning_threshold = 20;
              };
            };
          };
          brightness = {
            enable_ddcutil = false;
            minimum_brightness = 0.01;
            sync_all_monitors = true;
          };
          calendar = { };
          control_center = {
            calendar = {
              show_events_card = false;
              show_week_numbers = true;
            };
            shortcuts = [
              {
                type = "wifi";
              }
              {
                type = "bluetooth";
              }
              {
                type = "nightlight";
              }
              {
                type = "notification";
              }
              {
                type = "power_profile";
              }
              {
                type = "caffeine";
              }
            ];
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
                cx = 107.05999755859375;
                cy = 688.0;
                output = "LVDS-1";
                placement_height = 768.0;
                placement_width = 1366.0;
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
                placement_height = 768.0;
                placement_width = 1366.0;
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
                placement_height = 768.0;
                placement_width = 1366.0;
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
                cy = 88.69000244140625;
                flip_y = true;
                output = "LVDS-1";
                placement_height = 768.0;
                placement_width = 1366.0;
                rotation = 0.0010000000474974513;
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
          dock = {
            auto_hide = false;
            icon_size = 37;
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
          location = {
            auto_locate = true;
          };
          lockscreen = {
            blurred_desktop = true;
          };
          lockscreen_widgets = {
            enabled = true;
            schema_version = 2;
            widget_order = [
              "lockscreen-widget-000000000000000f"
              "lockscreen-login-box@HDMI-A-1"
              "lockscreen-login-box@VGA-1"
              "lockscreen-login-box@LVDS-1"
              "lockscreen-widget-000000000000000a"
              "lockscreen-widget-000000000000000d"
              "lockscreen-widget-000000000000000e"
              "lockscreen-widget-0000000000000008"
              "lockscreen-widget-0000000000000010"
              "lockscreen-widget-0000000000000011"
            ];
            grid = {
              cell_size = 64;
              major_interval = 4;
              visible = false;
            };
            widget = {
              "lockscreen-login-box@HDMI-A-1" = {
                box_height = 70.0;
                box_width = 400.0;
                cx = 960.0;
                cy = 991.0;
                output = "HDMI-A-1";
                placement_height = 1080.0;
                placement_width = 1920.0;
                rotation = 0.0;
                type = "login_box";
                settings = {
                  background_color = "surface_variant";
                  background_opacity = 0.88;
                  background_radius = 12.0;
                  center_password_text = false;
                  input_opacity = 1.0;
                  input_radius = 6.0;
                  layout = "compact";
                  show_caps_lock = true;
                  show_keyboard_layout = true;
                  show_login_button = true;
                  show_media = true;
                  show_session_buttons = true;
                  show_unlock_hint = true;
                  show_weather = true;
                };
              };
              "lockscreen-login-box@LVDS-1" = {
                box_height = 70.0;
                box_width = 400.0;
                cx = 683.0;
                cy = 686.0;
                output = "LVDS-1";
                placement_height = 768.0;
                placement_width = 1366.0;
                rotation = 0.0;
                type = "login_box";
                settings = {
                  background_opacity = 0.0;
                  center_password_text = false;
                  input_opacity = 1.0;
                  input_radius = 0.0;
                  layout = "compact";
                  show_caps_lock = true;
                  show_keyboard_layout = true;
                  show_login_button = true;
                  show_media = true;
                  show_session_buttons = false;
                  show_unlock_hint = false;
                  show_weather = true;
                };
              };
              "lockscreen-login-box@VGA-1" = {
                box_height = 196.0;
                box_width = 720.0;
                cx = 512.0;
                cy = 645.0;
                output = "VGA-1";
                placement_height = 0.0;
                placement_width = 0.0;
                rotation = 0.0;
                type = "login_box";
                settings = {
                  background_color = "surface_variant";
                  background_opacity = 0.88;
                  background_radius = 12.0;
                  center_password_text = false;
                  input_opacity = 1.0;
                  input_radius = 6.0;
                  layout = "regular";
                  show_caps_lock = true;
                  show_keyboard_layout = true;
                  show_login_button = true;
                  show_media = true;
                  show_session_buttons = true;
                  show_unlock_hint = true;
                  show_weather = true;
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
                box_height = 64.0;
                box_width = 64.0;
                cx = 844.0;
                cy = 644.0;
                output = "LVDS-1";
                placement_height = 768.0;
                placement_width = 1366.0;
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
                box_height = 88.0;
                box_width = 228.0;
                cx = 683.0;
                cy = 80.0;
                output = "LVDS-1";
                placement_height = 768.0;
                placement_width = 1366.0;
                rotation = 0.0;
                type = "clock";
                settings = {
                  background = true;
                  background_opacity = 0.34;
                  background_padding = 0;
                  background_radius = 19;
                  center_text = true;
                  clock_style = "digital";
                  font_family = "Hurmit Nerd Font";
                  shadow = true;
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
              lockscreen-widget-000000000000000d = {
                box_height = 192.0;
                box_width = 192.0;
                cx = 64.00000762939453;
                cy = 480.0;
                output = "LVDS-1";
                placement_height = 768.0;
                placement_width = 1366.0;
                rotation = 1.5707963705062866;
                type = "sysmon";
                settings = {
                  background_opacity = 0.0;
                  background_padding = 4;
                  background_radius = 0;
                  display = "graph";
                  shadow = true;
                  show_label = true;
                  stat = "cpu_usage";
                  stat2 = "cpu_temp";
                };
              };
              lockscreen-widget-000000000000000e = {
                box_height = 147.0;
                box_width = 324.0;
                cx = 1202.0;
                cy = 684.5;
                output = "LVDS-1";
                placement_height = 768.0;
                placement_width = 1366.0;
                rotation = 0.0;
                type = "media_player";
                settings = {
                  background_opacity = 0.0;
                  background_padding = 14;
                  background_radius = 0;
                  hide_when_no_media = true;
                  layout = "horizontal";
                  shadow = true;
                };
              };
              lockscreen-widget-000000000000000f = {
                box_height = 149.0;
                box_width = 175.0;
                cx = 845.5;
                cy = 644.5;
                output = "LVDS-1";
                placement_height = 768.0;
                placement_width = 1366.0;
                rotation = 0.0;
                type = "fancy_audio_visualizer";
                settings = {
                  background = false;
                  bar_width = 1.0;
                  bloom_intensity = 1.0;
                  inner_diameter = 0.0;
                  primary_color = "primary";
                  ring_opacity = 0.0;
                  rotation_speed = 1.2000000000000002;
                  secondary_color = "secondary";
                  sensitivity = 3.0;
                  visualization_mode = "rings";
                };
              };
              lockscreen-widget-0000000000000010 = {
                box_height = 128.0;
                box_width = 192.0;
                cx = 64.00000762939453;
                cy = 672.0;
                output = "LVDS-1";
                placement_height = 768.0;
                placement_width = 1366.0;
                rotation = 1.5707963705062866;
                type = "sysmon";
                settings = {
                  background_opacity = 0.0;
                  display = "graph";
                  gauge_layout = "horizontal";
                  stat = "ram_pct";
                  stat2 = "swap_pct";
                };
              };
              lockscreen-widget-0000000000000011 = {
                box_height = 0.0;
                box_width = 0.0;
                cx = 57.10000228881836;
                cy = 282.0;
                output = "LVDS-1";
                placement_height = 768.0;
                placement_width = 1366.0;
                rotation = 1.5707963705062866;
                type = "sysmon";
                settings = {
                  background_opacity = 0.0;
                  stat = "net_rx";
                  stat2 = "net_tx";
                };
              };
            };
          };
          nightlight = {
            enabled = true;
            temperature_day = 6500;
            temperature_night = 4300;
          };
          notification = {
            background_opacity = 0.0;
            history_retention_hours = 4;
            max_visible = 2;
            monitors = [
              "LVDS-1"
            ];
            offset_y = 9;
            scale = 0.8500000052154064;
          };
          osd = {
            background_opacity = 0.0;
            monitors = [
              "LVDS-1"
            ];
            offset_x = 15;
            offset_y = 5;
            position = "bottom_center";
            scale = 0.9000000059604645;
            kinds = {
              media = false;
            };
          };
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
          plugins = {
            enabled = [
              "noctalia/screen_recorder"
              "noctalia/notes"
              "whyoolw/sharednd"
              "nightwatch75/todo"
              "avivbintangaringga/nix-monitor"
              "raycursive/niri-displays"
              "noctalia/timer"
              "elars/valw"
            ];
          };
          shell = {
            app_icon_color = "on_hover";
            avatar_path = "${pictures}/noctalia/profile.png";
            corner_radius_scale = 0.0;
            external_ip_enabled = true;
            font_family = "Hurmit Nerd Font";
            launch_apps_as_systemd_services = true;
            niri_overview_type_to_launch_enabled = true;
            password_style = "random";
            polkit_agent = true;
            popup_shadows = false;
            screen_time_enabled = true;
            settings_show_advanced = true;
            telemetry_enabled = true;
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
            screen_corners = {
              size = 1;
            };
            screenshot = {
              annotate = true;
              close_on_copy = false;
              directory = "${pictures}/Screenshots";
            };
            session = {
              actions = [
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
            };
            shadow = {
              alpha = 0.0;
              direction = "up";
            };
          };
          system = {
            monitor = {
              cpu_temp_activity_threshold = 70;
              cpu_temp_critical_threshold = 80;
              cpu_usage_activity_threshold = 75;
            };
          };
          theme = {
            builtin = "Ayu";
            community_palette = "Kemuri Susu";
            custom_palette = "nix-wallpaper-nineish-mo";
            mode = "dark";
            source = "community";
            wallpaper_scheme = "m3-content";
            templates = {
              community_ids = [
                "telegram"
              ];
            };
          };
          wallpaper = {
            directory = "${pictures}/nix-wall-binary";
            edge_smoothness = 0.61;
            fill_mode = "repeat";
            transition = [
              "fade"
            ];
            transition_on_startup = true;
            automation = {
              enabled = true;
            };
            default = {
              path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-blue.png";
            };
            last = {
              path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-blue.png";
            };
            monitors = {
              HDMI-A-1 = {
                path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-blue.png";
              };
              LVDS-1 = {
                path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-blue.png";
              };
              VGA-1 = {
                path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-white.png";
              };
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
                path = "${pictures}/nix-wall-binary/nix-wallpaper-binary-white.png";
                theme_mode = "light";
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
            bar = {
              show_resolution = false;
              type = "raycursive/niri-displays:bar";
            };
            bongocat = {
              script = "scripts/bongocat.lua";
              type = "scripted";
            };
            cat = {
              type = "noctalia/bongocat:cat";
            };
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
              capsule_padding = 15;
              capsule_radius = "auto";
              color = "primary";
              display = "graph";
              glyph = "box-margin";
              icon_color = "primary";
              scale = 1.3;
              show_glyph = false;
              show_label = false;
              show_value = false;
              visualization = "graph";
            };
            custom_button_2 = {
              type = "custom_button";
            };
            launcher = {
              glyph = "box";
            };
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
            mpvpaper = {
              type = "noctalia/mpvpaper:mpvpaper";
            };
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
            ram = {
              show_glyph = false;
            };
            recorder = {
              color = "primary";
              icon_color = "on_tertiary";
              scale = 1.2;
              type = "noctalia/screen_recorder:recorder";
            };
            recorder_2 = {
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
            scripted_2 = {
              type = "scripted";
            };
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
                "Discord"
              ];
            };
            weather = {
              show_condition = false;
            };
            workspaces = {
              active_pill_size = 2.05;
              capsule_border = "shadow";
              capsule_fill = "shadow";
              capsule_foreground = "shadow";
              capsule_opacity = 0.24;
              capsule_padding = 0;
              capsule_radius = "auto";
              empty_color = "primary";
              focused_color = "surface_variant";
              focused_output_only = true;
              font_family = "Hurmit Nerd Font";
              font_scale = 0.81;
              font_weight = 700;
              inactive_pill_size = 0.25;
              label_source = "name";
              labels_only_when_occupied = false;
              max_label_chars = 10;
              occupied_color = "primary";
              pill_scale = 0.85;
              scale = 1.6;
              style = "regular";
            };
            valw = {
              scale = 1.2;
              type = "elars/valw:bar";
            };
          };
        };
      };
    };
}
