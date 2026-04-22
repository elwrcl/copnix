{ pkgs, inputs, ... }:

{
  imports = [ ./hypr/default.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    systemd.variables = [ "-all" ];
  };
}
