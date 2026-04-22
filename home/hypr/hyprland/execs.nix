{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "noctalia-shell"
      "hyprctl setcursor Bibata-Modern-Classic 24"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];
  };
}
