{ ... }:
{
  flake.homeModules.home-vscode-panels =
    { ... }:
    {
      programs.vscodium.profiles.default.keybindings = [
        # alt+s — explorer
        {
          key = "alt+s";
          command = "workbench.view.explorer";
        }
        {
          key = "alt+s";
          command = "workbench.action.closeSidebar";
          when = "sideBarFocus && activeViewlet == 'workbench.view.explorer'";
        }

        # alt+space — terminal 
        {
          key = "alt+space";
          command = "workbench.action.terminal.toggleTerminal";
        }

        # ctrl+space — source control
        {
          key = "ctrl+space";
          command = "workbench.view.scm";
        }
        {
          key = "ctrl+space";
          command = "workbench.action.toggleAuxiliaryBar";
          when = "auxiliaryBarFocus && activeAuxiliary == 'workbench.view.scm'";
        }
        {
          key = "ctrl+space";
          command = "workbench.action.closeSidebar";
          when = "sideBarFocus && activeViewlet == 'workbench.view.scm'";
        }
        {
          key = "ctrl+space";
          command = "-editor.action.triggerSuggest";
        }
      ];
    };
}
