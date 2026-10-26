{ ... }:
{
  flake.nixosModules.desktop-display =
    { ... }:
    {
      # No X server: niri is Wayland, X clients go through xwayland-satellite
      # (which brings its own Xwayland). xkb below still feeds kmscon.
      services.displayManager.ly = {
        enable = true;
        settings = {
          animation = "colormix";
          bigclock = "en";
          bigclock_12hr = false;
          blank_box = true;
          hide_borders = false;
          margin_box_h = 2;
          margin_box_v = 1;
        };
      };

      services.xserver.xkb = {
        layout = "tr";
        variant = "";
      };
    };
}
