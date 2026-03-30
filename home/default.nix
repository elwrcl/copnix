{ config, pkgs, inputs, system, ... }:

{
  imports = [ ./hyprland.nix ];

  home.username = "elars";
  home.homeDirectory = "/home/elars";
  home.stateVersion = "25.05";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = builtins.readFile /home/elars/.copdots/zsh/.zshrc;
  };

  programs.kitty = {
    enable = true;
    settings = {
      shell = "zsh";
      confirm_os_window_close = 0;
      background_opacity = "0.8";
      cursor_trail = 3;
    };
  };

  xdg.configFile = {
    "fastfetch".source = /home/elars/.copdots/fastfetch;
    "fish/functions".source = /home/elars/.copdots/fish/functions;
    "fish/completions".source = /home/elars/.copdots/fish/completions;
    "fish/conf.d".source = /home/elars/.copdots/fish/conf.d;
  };

  # Packs
  home.packages = with pkgs; [
    eza bat fzf fd micro fastfetch starship
    vulkan-tools libva-utils mesa-demos intel-gpu-tools clinfo
    nerd-fonts.symbols-only

    inputs.apple-fonts.packages.${system}.sf-pro
    inputs.apple-fonts.packages.${system}.sf-mono
  ];

  programs.starship.enable = true;
  programs.fzf.enable = true;
  home.file.".zshrc".source = /home/elars/.copdots/zsh/.zshrc;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
}
