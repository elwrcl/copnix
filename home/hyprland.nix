{
  pkgs,
  inputs,
  ...
}:

{
  imports = [ ./hypr/default.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    systemd.enable = false;
    systemd.variables = [ "-all" ];
  };
}
