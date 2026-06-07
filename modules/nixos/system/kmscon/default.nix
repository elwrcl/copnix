{ pkgs, ... }:

{
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  services.kmscon = {
    enable = true;

    config = {
      font-name = "JetBrainsMono Nerd Font";
      font-size = 18;
      hwaccel = true;
    };
  };
}
