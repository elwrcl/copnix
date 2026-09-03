{ ... }:
{
  flake.homeModules.desktop-niri-execs =
    { ... }:
    {
      programs.niri.settings = {
        "prefer-no-csd" = true;
        # noctalia ships its own clipboard history; no cliphist watcher needed.
        spawn-at-startup = [
          { command = [ "noctalia" ]; }
          { command = [ "xwayland-satellite" ]; }
        ];
      };
    };
}
