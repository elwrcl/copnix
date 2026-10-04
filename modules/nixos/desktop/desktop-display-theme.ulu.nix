{ ... }:
{
  flake.nixosModules.desktop-display-theme =
    { config, ... }:
    let
      p = config.home-manager.users.elars.elars.theme.palette;
    in
    {
      console.colors = [
        p.base00
        p.base08
        p.base0B
        p.base0A
        p.base0D
        p.base0E
        p.base0C
        p.base05
        p.base03
        p.base08
        p.base0B
        p.base09
        p.base0D
        p.base0E
        p.base0C
        p.base07
      ];
      services.displayManager.ly.settings = {
        full_color = false;
        fg = "0x00000008"; # base05
        bg = "0x00000000"; # slot 0, base00
        border_fg = "0x01000001"; # base03
        error_fg = "0x01000002"; # base08
        colormix_col1 = "0x00000008"; # base05
        colormix_col2 = "0x00000004"; # base0A
        colormix_col3 = "0x00000001"; # base00
      };
    };
}
