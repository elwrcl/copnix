{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "sleep 2 && noctalia-shell"
      "easyeffects --hide-window --service-mode"
      "gnome-keyring-daemon --start --components=secrets"
      "hyprctl setcursor Bibata-Modern-Classic 24"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];
  };
}
