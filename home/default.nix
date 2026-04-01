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
    initContent = builtins.readFile ./dots/zsh/.zshrc;
  };

  programs.ghostty = {
    enable = true;
    settings = {
    font-family = "JetBrainsMono Nerd Font";
    font-size = 11;
    background-opacity = 0.8;
    window-padding-x = 10;
    window-padding-y = 10;
  };
};

  xdg.configFile = {
    "fastfetch".source = ./dots/fastfetch;
    "fish/conf.d".source = ./dots/fish/conf.d;
  };

  home.packages = with pkgs; [
    eza bat fzf fd micro fastfetch starship
    vulkan-tools libva-utils mesa-demos intel-gpu-tools clinfo
    nerd-fonts.symbols-only zoxide trash-cli rsync

    inputs.apple-fonts.packages.${system}.sf-pro
    inputs.apple-fonts.packages.${system}.sf-mono
  ];

  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  services.mako.enable = false;
  services.kdeconnect.enable = true;
}
