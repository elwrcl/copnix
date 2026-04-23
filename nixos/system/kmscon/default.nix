{ pkgs, ... }:
{
  services.kmscon = {
    enable = true;
    autologin = true;
    hwRender = true;
    fonts = [{
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    }];
    extraConfig = ''
      font-size=12
    '';
  };
}
