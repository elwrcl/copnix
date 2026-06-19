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
    };
    animations = {
      slowdown = 0.8;
    };
    layout = {
      gaps = 5;
      struts = {
        left = -3;
        right = -3;
        top = -3;
        bottom = -3;
      };
      center-focused-column = "never";
      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];
      default-column-width = {
        proportion = 0.5;
      };
      focus-ring = {
        width = 2;
        active.color = "#61afef";
        inactive.color = "#444444";
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
