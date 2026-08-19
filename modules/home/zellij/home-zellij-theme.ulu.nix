{ ... }:
{
  flake.homeModules.home-zellij-theme =
    { ... }:
    # this could be change
    {
      programs.zellij.themes.kanagawa-dragon-copnix = ''
        themes {
            kanagawa-dragon-copnix {
                text_unselected {
                    base 197 201 199
                    background 9 14 19
                    emphasis_0 182 146 123
                    emphasis_1 127 180 202
                    emphasis_2 138 154 123
                    emphasis_3 162 146 163
                }
                text_selected {
                    base 9 14 19
                    background 127 180 202
                    emphasis_0 182 146 123
                    emphasis_1 9 14 19
                    emphasis_2 138 154 123
                    emphasis_3 162 146 163
                }
                ribbon_selected {
                    base 9 14 19
                    background 127 180 202
                    emphasis_0 196 116 110
                    emphasis_1 182 146 123
                    emphasis_2 162 146 163
                    emphasis_3 139 164 176
                }
                ribbon_unselected {
                    base 197 201 199
                    background 34 38 45
                    emphasis_0 196 116 110
                    emphasis_1 197 201 199
                    emphasis_2 139 164 176
                    emphasis_3 162 146 163
                }
                table_title {
                    base 138 154 123
                    background 0
                    emphasis_0 182 146 123
                    emphasis_1 127 180 202
                    emphasis_2 138 154 123
                    emphasis_3 162 146 163
                }
                table_cell_selected {
                    base 9 14 19
                    background 127 180 202
                    emphasis_0 182 146 123
                    emphasis_1 9 14 19
                    emphasis_2 138 154 123
                    emphasis_3 162 146 163
                }
                table_cell_unselected {
                    base 197 201 199
                    background 9 14 19
                    emphasis_0 182 146 123
                    emphasis_1 127 180 202
                    emphasis_2 138 154 123
                    emphasis_3 162 146 163
                }
                list_selected {
                    base 9 14 19
                    background 127 180 202
                    emphasis_0 182 146 123
                    emphasis_1 9 14 19
                    emphasis_2 138 154 123
                    emphasis_3 162 146 163
                }
                list_unselected {
                    base 197 201 199
                    background 9 14 19
                    emphasis_0 182 146 123
                    emphasis_1 127 180 202
                    emphasis_2 138 154 123
                    emphasis_3 162 146 163
                }
                frame_selected {
                    base 127 180 202
                    background 0
                    emphasis_0 182 146 123
                    emphasis_1 138 154 123
                    emphasis_2 162 146 163
                    emphasis_3 0
                }
                frame_highlight {
                    base 182 146 123
                    background 0
                    emphasis_0 162 146 163
                    emphasis_1 182 146 123
                    emphasis_2 182 146 123
                    emphasis_3 182 146 123
                }
                exit_code_success {
                    base 138 154 123
                    background 0
                    emphasis_0 127 180 202
                    emphasis_1 9 14 19
                    emphasis_2 162 146 163
                    emphasis_3 139 164 176
                }
                exit_code_error {
                    base 228 104 118
                    background 0
                    emphasis_0 230 195 132
                    emphasis_1 0
                    emphasis_2 0
                    emphasis_3 0
                }
                multiplayer_user_colors {
                    player_1 162 146 163
                    player_2 139 164 176
                    player_3 0
                    player_4 230 195 132
                    player_5 127 180 202
                    player_6 0
                    player_7 196 116 110
                    player_8 0
                    player_9 0
                    player_10 0
                }
            }
        }
      '';
    };
}
