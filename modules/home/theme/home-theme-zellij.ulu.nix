{ ... }:
{
  flake.homeModules.home-theme-zellij =
    { config, lib, ... }:
    let
      p = config.elars.theme.palette;

      c = hex: lib.concatMapStringsSep " " toString (config.elars.theme.hexToRgb hex);

      bg = c p.base00;
      bgAlt = c p.base01;
      fg = c p.base05;
      accent = c (p.accent or p.base06);
      orange = c p.base09;
      yellow = c p.base0A;
      green = c p.base0B;
      cyan = c p.base0C;
      blue = c p.base0D;
      magenta = c p.base0E;
      red = c p.base08;

      slot =
        {
          base,
          background,
          e0 ? orange,
          e1 ? blue,
          e2 ? green,
          e3 ? magenta,
        }:
        lib.concatStringsSep "\n            " [
          "base ${base}"
          "background ${background}"
          "emphasis_0 ${e0}"
          "emphasis_1 ${e1}"
          "emphasis_2 ${e2}"
          "emphasis_3 ${e3}"
        ];

      unselected = slot {
        base = fg;
        background = bg;
      };

      selected = slot {
        base = bg;
        background = accent;
        e1 = bg;
      };
    in
    {
      programs.zellij.themes.kemuri-copnix = ''
        themes {
            kemuri-copnix {
                text_unselected {
                    ${unselected}
                }
                text_selected {
                    ${selected}
                }
                ribbon_selected {
                    ${slot {
                      base = bg;
                      background = accent;
                      e0 = red;
                      e1 = yellow;
                      e2 = magenta;
                      e3 = blue;
                    }}
                }
                ribbon_unselected {
                    ${slot {
                      base = fg;
                      background = bgAlt;
                      e0 = red;
                      e1 = fg;
                      e2 = blue;
                      e3 = magenta;
                    }}
                }
                table_title {
                    ${slot {
                      base = green;
                      background = bg;
                    }}
                }
                table_cell_selected {
                    ${selected}
                }
                table_cell_unselected {
                    ${unselected}
                }
                list_selected {
                    ${selected}
                }
                list_unselected {
                    ${unselected}
                }
                frame_selected {
                    ${slot {
                      base = accent;
                      background = bg;
                      e1 = green;
                      e2 = magenta;
                      e3 = bg;
                    }}
                }
                frame_highlight {
                    ${slot {
                      base = orange;
                      background = bg;
                      e0 = magenta;
                      e1 = orange;
                      e2 = orange;
                      e3 = orange;
                    }}
                }
                exit_code_success {
                    ${slot {
                      base = green;
                      background = bg;
                      e0 = accent;
                      e1 = bg;
                      e2 = magenta;
                      e3 = blue;
                    }}
                }
                exit_code_error {
                    ${slot {
                      base = red;
                      background = bg;
                      e0 = yellow;
                      e1 = bg;
                      e2 = bg;
                      e3 = bg;
                    }}
                }
                multiplayer_user_colors {
                    player_1 ${magenta}
                    player_2 ${blue}
                    player_3 ${cyan}
                    player_4 ${yellow}
                    player_5 ${accent}
                    player_6 ${green}
                    player_7 ${red}
                    player_8 ${orange}
                    player_9 ${fg}
                    player_10 ${bgAlt}
                }
            }
        }
      '';
    };
}
