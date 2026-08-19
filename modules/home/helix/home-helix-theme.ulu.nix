{ ... }:
{
  # this could be changed
  flake.homeModules.home-helix-theme =
    { ... }:
    {
      programs.helix.themes.kanagawa-dragon-copnix = {
        inherits = "kanagawa-dragon";

        palette = {
          copBg = "#090E13";
          copBgAlt = "#0E141B";
          copBgSoft = "#151B22";
          copSelect = "#22262D";
          copGutter = "#3A414B";
          copGray = "#5C6066";
          copFg = "#c5c9c7";
          copRed = "#c4746e";
          copRedBright = "#e46876";
          copGreen = "#8a9a7b";
          copYellow = "#c4b28a";
          copYellowBright = "#e6c384";
          copBlue = "#8ba4b0";
          copBlueBright = "#7fb4ca";
          copMagenta = "#a292a3";
          copCyan = "#8ea4a2";
        };

        "ui.background" = {
          fg = "copFg";
          bg = "copBg";
        };
        "ui.text" = "copFg";
        "ui.window" = "copBgSoft";

        "ui.gutter" = {
          bg = "copBg";
        };
        "ui.linenr" = {
          fg = "copGutter";
          bg = "copBg";
        };
        "ui.linenr.selected" = {
          fg = "copYellowBright";
          bg = "copBg";
          modifiers = [ "bold" ];
        };

        "ui.cursorline.primary" = {
          bg = "copBgAlt";
        };
        "ui.cursorline.secondary" = {
          bg = "copBgAlt";
        };

        "ui.selection" = {
          bg = "copSelect";
        };
        "ui.selection.primary" = {
          bg = "#2A3038";
        };

        "ui.statusline" = {
          fg = "copFg";
          bg = "copBgSoft";
        };
        "ui.statusline.inactive" = {
          fg = "copGray";
          bg = "copBgAlt";
        };
        "ui.statusline.normal" = {
          fg = "copBg";
          bg = "copBlueBright";
          modifiers = [ "bold" ];
        };
        "ui.statusline.insert" = {
          fg = "copBg";
          bg = "copGreen";
          modifiers = [ "bold" ];
        };
        "ui.statusline.select" = {
          fg = "copBg";
          bg = "copMagenta";
          modifiers = [ "bold" ];
        };

        "ui.bufferline" = {
          fg = "copGray";
          bg = "copBgAlt";
        };
        "ui.bufferline.active" = {
          fg = "copFg";
          bg = "copBgSoft";
          modifiers = [ "bold" ];
        };
        "ui.bufferline.background" = {
          bg = "copBg";
        };

        "ui.popup" = {
          fg = "copFg";
          bg = "copBgSoft";
        };
        "ui.popup.info" = {
          fg = "copFg";
          bg = "copBgAlt";
        };
        "ui.menu" = {
          fg = "copFg";
          bg = "copBgSoft";
        };
        "ui.menu.selected" = {
          fg = "copBg";
          bg = "copBlueBright";
          modifiers = [ "bold" ];
        };
        "ui.help" = {
          fg = "copFg";
          bg = "copBgSoft";
        };

        "ui.virtual.indent-guide" = "copGutter";
        "ui.virtual.ruler" = {
          bg = "copBgAlt";
        };
        "ui.virtual.whitespace" = "copGutter";
        "diff.plus" = "copGreen";
        "diff.minus" = "copRedBright";
        "diff.delta" = "copBlueBright";
      };
    };
}
