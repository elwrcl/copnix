{ ... }:
{
  flake.homeModules.home-qt =
    { pkgs, ... }:
    {
      qt = {
        enable = true;
        platformTheme.name = "kde";
        style.name = "kvantum";
      };

      xdg.configFile."Kvantum/WhiteSur-Dark/WhiteSur-Dark.kvconfig".source =
        "${pkgs.whitesur-kde}/share/Kvantum/WhiteSur/WhiteSurDark.kvconfig";
      xdg.configFile."Kvantum/WhiteSur-Dark/WhiteSur-Dark.svg".source =
        "${pkgs.whitesur-kde}/share/Kvantum/WhiteSur/WhiteSurDark.svg";

      xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=WhiteSur-Dark
      '';

      xdg.configFile."kdeglobals".text = ''
        [General]
        font=JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0
        fixed=JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0
        menuFont=JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0
        toolBarFont=JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0
        smallestReadableFont=JetBrainsMono Nerd Font,9,-1,5,50,0,0,0,0,0
      '';
    };
}
