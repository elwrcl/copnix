{ ... }:
{
  flake.homeModules.home-vscode-projects =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.elars.vscode.projectRoots = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ config.home.homeDirectory ];
      };

      config.programs.vscodium.profiles.default = {
        extensions = [ pkgs.vscode-extensions.alefragnani.project-manager ];

        userSettings = {
          "projectManager.git.baseFolders" = config.elars.vscode.projectRoots;
          "projectManager.git.maxDepthRecursion" = 2;
          "projectManager.git.ignoredFolders" = [
            ".direnv"
            ".git"
            ".jj"
            "build"
            "node_modules"
            "result"
            "target"
          ];
          "projectManager.sortList" = "Recent";
        };

        # space o — project manager
        keybindings = [
          {
            key = "space o";
            command = "projectManager.listProjects";
            when = "editorTextFocus && (extension.helixKeymap.normalMode || extension.helixKeymap.visualMode)";
          }
        ];
      };
    };
}
