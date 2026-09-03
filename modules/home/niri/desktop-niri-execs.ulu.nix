{ ... }:
{
  flake.homeModules.desktop-niri-execs =
    { ... }:
    {
      programs.niri.settings = {
        "prefer-no-csd" = true;
        spawn-at-startup = [
          { command = [ "noctalia" ]; }
          { command = [ "xwayland-satellite" ]; }
        ];
      };
    };
}
