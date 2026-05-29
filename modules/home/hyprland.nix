{
  pkgs,
  inputs,
  ...
}:

{
  imports = [ ./hypr/default.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    configType = "hyprlang";
    xwayland.enable = true;
    systemd.enable = false;
    systemd.variables = [ "-all" ];
  };
}
