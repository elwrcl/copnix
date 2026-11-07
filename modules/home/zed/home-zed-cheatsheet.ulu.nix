{ ... }:
{
  flake.homeModules.home-zed-cheatsheet =
    { config, ... }:
    let
      path = "${config.xdg.configHome}/zed/cheatsheet.md";
    in
    {
      xdg.configFile."zed/cheatsheet.md".source = ./cheatsheet.md;

      programs.zed-editor = {
        userTasks = [
          {
            label = "cheatsheet";
            command = "${config.programs.zed-editor.package}/bin/zeditor";
            args = [
              "--existing"
              path
            ];
            reveal = "never";
            hide = "always";
          }
        ];

        userKeymaps = [
          {
            context = "Workspace";
            bindings."f1" = [
              "task::Spawn"
              { task_name = "cheatsheet"; }
            ];
          }
        ];
      };
    };
}
