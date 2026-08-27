{ inputs, ... }:
{
  flake.homeModules.home-theme-kemuri =
    { ... }:
    {
      elars.theme.palette = inputs.themes.custom {
        name = "Kemuri Susu";
        author = "elars";

        base00 = "1e1d1b";
        base01 = "282624";
        base02 = "34312d";
        base03 = "594f46";
        base04 = "73685f";
        base05 = "f0ede6";
        base06 = "cabaaa";
        base07 = "fafbfe";

        base08 = "cf7670"; # red    / mError
        base09 = "d1ba94"; # orange (approximated, see note above)
        base0A = "bfa67a"; # yellow
        base0B = "8ca38a"; # green
        base0C = "7fa39a"; # cyan
        base0D = "78909c"; # blue
        base0E = "b38f99"; # magenta
        base0F = "594f46"; # brown  / mTertiary

        accent = "cabaaa";
      };
    };
}
