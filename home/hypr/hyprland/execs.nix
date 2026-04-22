{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "noctalia-shell"
      "hyprctl setcursor Bibata-Modern-Classic 24"
      "easyeffects --hide-window --service-mode"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "sleep 2 && systemctl --user restart xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk"
    ];
  };
}
