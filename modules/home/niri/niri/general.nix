{ ... }:

{
  programs.niri.settings = {
    input = {
      keyboard = {
        xkb = {
          layout = "tr";
        };
        repeat-delay = 250;
        repeat-rate = 35;
      };
      mouse = {
        accel-speed = 0.0;
        accel-profile = "flat";
      };
      touchpad = {
        tap = true;
        natural-scroll = true;
        scroll-factor = 0.5;
        click-method = "clickfinger";
      };
      focus-follows-mouse = {
        max-scroll-amount = "0%";
      };
    };

    outputs = {
      "LVDS-1" = {
        position = {
          x = 0;
          y = 0;
        };
      };
      "HDMI-A-1" = {
        position = {
          x = -277;
          y = -1080;
        };
      };
    };

    animations = {
      slowdown = 0.8;
    };

    layout = {
      gaps = 5;
      struts = {
        left = -5;
        right = -5;
        top = -5;
        bottom = -5;
      };
      center-focused-column = "never";
      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];
      default-column-width = {
        proportion = 1.0;
      };
      focus-ring = {
        enable = false;
      };
      border = {
        enable = false;
      };
    };

    layer-rules = [
      {
        matches = [
          { namespace = "^noctalia-backdrop"; }
        ];
        place-within-backdrop = true;
      }
    ];
  };
}
