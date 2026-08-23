{ ... }:
{
  flake.homeModules.home-nushell-last =
    { ... }:
    {
      programs.nushell.extraConfig = ''
        $env.config.hooks.display_output = {||
          tee { table --expand | print }
          # SQLiteDatabase doesn't support equality comparisons.
          | try { if $in != null { $env.last = $in } }
        }

        # Retrieve the output of the last command.
        def _ []: nothing -> any {
          $env.last?
        }
      '';
    };
}
