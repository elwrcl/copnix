{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      nerd-fonts.hurmit
      noto-fonts
      ipaexfont
    ];

    fontconfig = {
      enable = true;
      antialias = true;

      hinting = {
        enable = true;
        style = "slight";
        autohint = false;
      };

      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };

      defaultFonts = {
        serif = [
          "JetBrainsMono Nerd Font"
          "Noto Serif CJK JP"
          "Noto Serif"
          "IPAexMincho"
        ];
        sansSerif = [
          "JetBrainsMono Nerd Font"
          "Noto Sans CJK JP"
          "Noto Sans"
          "IPAexGothic"
        ];
        monospace = [
          "JetBrainsMono Nerd Font Mono"
          "JetBrainsMono Nerd Font"
          "Noto Sans Mono CJK JP"
          "Noto Sans CJK JP"
          "IPAexGothic"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
