{ ... }:
{
  flake.homeModules.home-valw =
    { inputs, ... }:
    {
      imports = [ inputs.valw.homeModules.default ];

      programs.valw = {
        enable = true;
        settings = {
          capture.window_shadow = true;
          editor.backend = "noctalia";
          theme.style = "nier";
        };
        noctalia.enable = true;
      };
    };
}
