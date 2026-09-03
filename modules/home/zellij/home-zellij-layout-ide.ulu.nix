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
                pane split_direction="vertical" {
                    pane size="20%" name="files" command="hx-sidebar" close_on_exit=true {
                        args "."
                    }
                    pane focus=true command="hx" close_on_exit=true
                }

                floating_panes {
                    pane name="terminal" command="nu" {
                        x "5%"
                        y "52%"
                        width "90%"
                        height "44%"
                    }
                }
            }
        }
      '';
    };
}
