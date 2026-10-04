{ ... }:
{
  flake.homeModules.home-valw =
    { inputs, ... }:
    {
      imports = [ inputs.valw.homeModules.default ];

      programs.valw = {
        enable = true;
        # Checked by valw itself when the configuration is built.
        settings = {
          capture.window_shadow = true;
          # Noctalia's annotator, in the shell's theme (saves a new file).
          editor.backend = "noctalia";
        };
        # A bar button, the toolbar as a Noctalia panel, a control-center tile.
        noctalia.enable = true;
      };
    };
}
