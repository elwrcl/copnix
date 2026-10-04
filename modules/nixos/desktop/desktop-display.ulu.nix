{ ... }:
{
  flake.nixosModules.desktop-display =
    { ... }:
    {
      services.xserver.enable = true;
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
