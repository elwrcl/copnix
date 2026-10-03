{ ... }:
{
  flake.homeModules.desktop-niri-execs =
    { ... }:
    {
      programs.niri.settings = {
        "prefer-no-csd" = true;
        spawn-at-startup = [
          { command = [ "noctalia" ]; }
          # valw's paint shader behind the overview (see the layer rule).
          { command = [ "valw" "backdrop" ]; }
        ];
      };
    };
}
