{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,1";

    general = {
      gaps_in = 4;
      gaps_out = 5;
      border_size = 2;
      "col.active_border" = "rgba(ff6b6bff) rgba(4ecdc4ff) 90deg";
      "col.inactive_border" = "rgba(31313622)";
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
      notify_on_column_change = true;
    };

    decoration = {
      rounding = 18;
      rounding_power = 2;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      dim_inactive = true;
      dim_strength = 0.05;
      blur = {
        enabled = false;
      };
      shadow = {
        enabled = false;
      };
    };

    input = {
      kb_layout = "tr";
      numlock_by_default = true;
      repeat_delay = 250;
      repeat_rate = 35;
      sensitivity = 0.0;
      accel_profile = "flat";
      follow_mouse = 1;
      force_no_accel = true;
      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        clickfinger_behavior = true;
        scroll_factor = 0.8;
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
      "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"
      "emphasizedDecel, 0.05, 0.7, 0.1, 1"
      "emphasizedAccel, 0.3, 0, 0.8, 0.15"
      "standardDecel, 0, 0, 0, 1"
      "menu_decel, 0.1, 1, 0, 1"
      "menu_accel, 0.52, 0.03, 0.72, 0.08"
      "stall, 1, -0.1, 0.7, 0.85"
      "smoothIn, 0.25, 0.46, 0.45, 0.94"
      "smoothOut, 0.42, 0, 0.58, 1"
      "smoothInOut, 0.42, 0, 0.58, 1"
    ];

    animation = [
      "windowsIn,  1, 4, smoothOut, popin 75%"
      "windowsOut, 1, 3, smoothIn, popin 85%"
      "windowsMove, 1, 4, smoothOut, slide"
      "fadeIn,     1, 3, smoothOut"
      "fadeOut,    1, 2.5, smoothIn"
      "border,     1, 8, smoothOut"
      "layersIn,   1, 3, smoothOut, popin 90%"
      "layersOut,  1, 2, smoothIn, popin 92%"
      "fadeLayersIn,  1, 1, smoothOut"
      "fadeLayersOut, 1, 2, smoothIn"
      "workspaces, 1, 6, smoothOut, slide"
      "specialWorkspaceIn,  1, 3, smoothOut, slidevert"
      "specialWorkspaceOut, 1, 2, smoothIn, slidevert"
    ];

    device = [
      {
        name = "hp--inc-hyperx-cloud-alpha-s-consumer-control";
        enabled = false;
      }
    ];

  };
}
