{ ... }:
{
  flake.homeModules.home-zellij-layout-ide =
    { ... }:
    {
      programs.zellij.layouts.ide = ''
        layout {
            default_tab_template {
                pane size=1 borderless=true {
                    plugin location="zellij:compact-bar"
                }
                children
            }

            tab name="edit" focus=true {
                pane command="hx" close_on_exit=true {
                    args "."
                }
            }
        }
      '';
    };
}
