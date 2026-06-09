{ ... }:

{
  programs.niri.settings = {
    "prefer-no-csd" = true;
    spawn-at-startup = [
      { command = [ "noctalia" ]; }
      { command = [ "xwayland-satellite" ]; }
      { command = [ "sh" "-c" "wl-paste --type text --watch cliphist store" ]; }
      { command = [ "sh" "-c" "wl-paste --type image --watch cliphist store" ]; }
    ];
  };
}