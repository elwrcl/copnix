{
  pkgs,
  inputs,
  config,
  ...
}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland.enable = true;
    systemd.enable = false;
    systemd.variables = [ "-all" ];
    extraConfig = ''
      source = /home/elars/.config/copdots/config/hypr/hyprland.conf
    '';
  };

  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "/home/elars/.config/copdots/config/waybar";
  xdg.configFile."rofi".source =
    config.lib.file.mkOutOfStoreSymlink "/home/elars/.config/copdots/config/rofi";
  xdg.configFile."cava".source =
    config.lib.file.mkOutOfStoreSymlink "/home/elars/.config/copdots/config/cava";
  xdg.configFile."eww".source =
    config.lib.file.mkOutOfStoreSymlink "/home/elars/.config/copdots/config/eww";
}
