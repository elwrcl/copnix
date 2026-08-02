{ ... }:
{
  flake.homeModules.home-jujutsu-watchman =
    { pkgs, lib, ... }:
    {
      home.packages = [ pkgs.watchman ];

      xdg.configFile."watchman/watchman.json".text = builtins.toJSON {
        ignore_dirs = [
          ".direnv"
          "node_modules"
          "target"
        ];
      };

      programs.jujutsu.settings = {
        fsmonitor.backend = "watchman";
        fsmonitor.watchman.register-snapshot-trigger = true;
      };
    };
}
