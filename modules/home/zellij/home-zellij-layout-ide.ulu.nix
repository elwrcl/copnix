{ ... }:
{
  flake.homeModules.home-zellij-layout-ide =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      p = config.elars.theme.palette;
      c = hex: "#${hex}";
      bg = c p.base00;
      bgAlt = c p.base01;
      dim = c p.base03;
      muted = c p.base04;
      accent = c p.accent;

      mode =
        key: background: label:
        ''mode_${key} "#[bg=${background},fg=${bg},bold] ${label} "'';

      modes = lib.concatStringsSep "\n                " [
        (mode "normal" (c p.base0B) "NORMAL")
        (mode "tmux" (c p.base09) "ZELLIJ")
        (mode "locked" dim "LOCKED")
        (mode "resize" (c p.base0D) "RESIZE")
        (mode "scroll" (c p.base0C) "SCROLL")
        (mode "search" (c p.base0C) "SEARCH")
        (mode "entersearch" (c p.base0C) "SEARCH")
        (mode "renametab" (c p.base0E) "RENAME")
        (mode "renamepane" (c p.base0E) "RENAME")
      ];
    in
    {
      programs.zellij.layouts.ide = ''
        layout {
            default_tab_template {
                pane size=1 borderless=true {
                    plugin location="file:${pkgs.zellijPlugins.zjstatus}" {
                        format_left  "{mode}#[bg=${bgAlt},fg=${accent},bold] {session} #[bg=${bg}] {tabs}"
                        format_right "#[bg=${bg},fg=${dim}]{swap_layout} {datetime}"
                        format_space "#[bg=${bg}]"

                        border_enabled "false"
                        hide_frame_for_single_pane "false"

                        ${modes}

                        tab_normal "#[bg=${bgAlt},fg=${muted}] {index} {name} "
                        tab_active "#[bg=${accent},fg=${bg},bold] {index} {name} "

                        datetime          "#[bg=${bg},fg=${muted},bold] {format} "
                        datetime_format   "%H:%M"
                        datetime_timezone "Europe/Istanbul"
                    }
                }
                children
            }

            tab name="edit" focus=true {
                pane split_direction="vertical" {
                    pane size=40 name="files" command="hx-sidebar" close_on_exit=true {
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

           swap_tiled_layout name="vertical" {
                tab {
                    pane split_direction="vertical" { children; }
                }
            }

            swap_tiled_layout name="horizontal" {
                tab {
                    pane split_direction="horizontal" { children; }
                }
            }

            swap_tiled_layout name="stacked" {
                tab {
                    pane stacked=true { children; }
                }
            }
        }
      '';
    };
}
