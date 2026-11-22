{ ... }:
{
  flake.homeModules.home-theme-quickshell =
    { config, lib, ... }:
    let
      variant = p: {
        bg = "#${p.base00}";
        bg2 = "#${p.base01}";
        bg3 = "#${p.base02}";
        fg = "#${p.base06}";
        fgd = "#80${p.base06}";
        fgdd = "#33${p.base06}";
        ln = "#1F${p.base06}";
        lnm = "#38${p.base06}";
        a1 = "#${p.base08}";
        a2 = "#${p.base0B}";
        a3 = "#${p.base0D}";
        a4 = "#${p.base0A}";
        mono = "Share Tech Mono";
      };
    in
    {
      xdg.configFile =
        lib.concatMapAttrs
          (mode: palette: {
            "elars-theme/${mode}/quickshell-theme.json".text = builtins.toJSON (variant palette);
          })
          {
            dark = config.elars.theme.palette;
            light = config.elars.theme.paletteLight;
          };
    };
}
