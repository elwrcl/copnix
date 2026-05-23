{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        _args = [
          ""
          "preferred"
          "auto"
          "1"
        ];
      }
    ];

    general = {
      gaps_in = 4;
      gaps_out = 5;
      border_size = 2;
      "col.active_border" = "rgba(ffffffff)";
      "col.inactive_border" = "rgba(ffffff66)";
      resize_on_border = true;
      allow_tearing = true;
      layout = "scrolling";
    };

    scrolling = {
      column_width = 0.45;
      fullscreen_on_one_column = true;
      focus_fit_method = 1;
      follow_focus = true;
      direction = "right";
    };

    decoration = {
      rounding = 0;
      rounding_power = 2;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      dim_inactive = true;
      dim_strength = 0.05;
      blur = {
        enabled = true;
      };
      shadow = {
        enabled = true;
      };
    };

    input = {
      kb_layout = "tr";
      numlock_by_default = true;
      repeat_delay = 250;
      repeat_rate = 35;
      sensitivity = -5;
      accel_profile = "adaptive";
      follow_mouse = 1;
      #force_no_accel = true;
      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        clickfinger_behavior = true;
        scroll_factor = 0.5;
      };
    };

    gestures = {
      workspace_swipe_distance = 700;
      workspace_swipe_cancel_ratio = 0.2;
      workspace_swipe_min_speed_to_force = 5;
      workspace_swipe_direction_lock = true;
      workspace_swipe_create_new = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      animate_manual_resizes = false;
      focus_on_activate = false;
    };

    bezier = [
      {
        _args = [
          "omniDecel"
          "0.05"
          "0.9"
          "0.1"
          "1"
        ];
      }
      {
        _args = [
          "omniAccel"
          "0.3"
          "0"
          "0.8"
          "0.15"
        ];
      }
      {
        _args = [
          "omniSmooth"
          "0.25"
          "0.1"
          "0.25"
          "1"
        ];
      }
      {
        _args = [
          "omniOvershoot"
          "0.16"
          "1"
          "0.3"
          "1"
        ];
      }
      {
        _args = [
          "menu_decel"
          "0.1"
          "1"
          "0"
          "1"
        ];
      }
      {
        _args = [
          "menu_accel"
          "0.52"
          "0.03"
          "0.72"
          "0.08"
        ];
      }
    ];

    animation = [
      {
        _args = [
          "windowsIn"
          "1"
          "6"
          "omniOvershoot"
          "popin 86%"
        ];
      }
      {
        _args = [
          "windowsOut"
          "1"
          "5"
          "omniAccel"
          "popin 92%"
        ];
      }
      {
        _args = [
          "windowsMove"
          "1"
          "6"
          "omniDecel"
          "slide"
        ];
      }
      {
        _args = [
          "fadeIn"
          "1"
          "5"
          "omniDecel"
        ];
      }
      {
        _args = [
          "fadeOut"
          "1"
          "4"
          "omniAccel"
        ];
      }
      {
        _args = [
          "border"
          "1"
          "10"
          "omniSmooth"
        ];
      }
      {
        _args = [
          "layersIn"
          "1"
          "5"
          "omniDecel"
          "popin 92%"
        ];
      }
      {
        _args = [
          "layersOut"
          "1"
          "4"
          "omniAccel"
          "popin 94%"
        ];
      }
      {
        _args = [
          "fadeLayersIn"
          "1"
          "3"
          "omniDecel"
        ];
      }
      {
        _args = [
          "fadeLayersOut"
          "1"
          "3"
          "omniAccel"
        ];
      }
      {
        _args = [
          "workspaces"
          "1"
          "8"
          "omniDecel"
          "slide"
        ];
      }
      {
        _args = [
          "specialWorkspaceIn"
          "1"
          "5"
          "omniDecel"
          "slidevert"
        ];
      }
      {
        _args = [
          "specialWorkspaceOut"
          "1"
          "4"
          "omniAccel"
          "slidevert"
        ];
      }
    ];

    device = [
      {
        name = "hp--inc-hyperx-cloud-alpha-s-consumer-control";
        enabled = false;
      }
    ];

  };
}
