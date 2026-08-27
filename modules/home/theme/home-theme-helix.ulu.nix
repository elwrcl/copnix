{ ... }:
{
  flake.homeModules.home-theme-helix =
    { config, ... }:
    let
      p = config.elars.theme.palette.withHashtag;
    in
    {
      programs.helix.themes.kemuri-copnix = {
        palette = {
          bg = p.base00;
          bgAlt = p.base01;
          bgSoft = p.base02;
          select = p.base02;
          selectPrimary = p.base03;
          gutter = p.base03;
          gray = p.base04;
          fg = p.base05;
          fgSoft = p.base06;
          fgBright = p.base07;
          red = p.base08;
          orange = p.base09;
          yellow = p.base0A;
          green = p.base0B;
          cyan = p.base0C;
          blue = p.base0D;
          magenta = p.base0E;
          brown = p.base0F;
        };

        # ui
        "ui.background" = {
          fg = "fg";
          bg = "bg";
        };
        "ui.text" = "fg";
        "ui.text.focus" = {
          fg = "fgBright";
          modifiers = [ "bold" ];
        };
        "ui.window" = "bgSoft";
        "ui.cursor" = {
          fg = "bg";
          bg = "fgSoft";
        };
        "ui.cursor.primary" = {
          fg = "bg";
          bg = "fgBright";
        };
        "ui.cursor.match" = {
          fg = "orange";
          modifiers = [ "bold" ];
        };

        "ui.gutter" = {
          bg = "bg";
        };
        "ui.linenr" = {
          fg = "gutter";
          bg = "bg";
        };
        "ui.linenr.selected" = {
          fg = "orange";
          bg = "bg";
          modifiers = [ "bold" ];
        };

        "ui.cursorline.primary" = {
          bg = "bgAlt";
        };
        "ui.cursorline.secondary" = {
          bg = "bgAlt";
        };

        "ui.selection" = {
          bg = "select";
        };
        "ui.selection.primary" = {
          bg = "selectPrimary";
        };

        "ui.statusline" = {
          fg = "fg";
          bg = "bgSoft";
        };
        "ui.statusline.inactive" = {
          fg = "gray";
          bg = "bgAlt";
        };
        "ui.statusline.normal" = {
          fg = "bg";
          bg = "blue";
          modifiers = [ "bold" ];
        };
        "ui.statusline.insert" = {
          fg = "bg";
          bg = "green";
          modifiers = [ "bold" ];
        };
        "ui.statusline.select" = {
          fg = "bg";
          bg = "magenta";
          modifiers = [ "bold" ];
        };

        "ui.bufferline" = {
          fg = "gray";
          bg = "bgAlt";
        };
        "ui.bufferline.active" = {
          fg = "fg";
          bg = "bgSoft";
          modifiers = [ "bold" ];
        };
        "ui.bufferline.background" = {
          bg = "bg";
        };

        "ui.popup" = {
          fg = "fg";
          bg = "bgSoft";
        };
        "ui.popup.info" = {
          fg = "fg";
          bg = "bgAlt";
        };
        "ui.menu" = {
          fg = "fg";
          bg = "bgSoft";
        };
        "ui.menu.selected" = {
          fg = "bg";
          bg = "fgSoft";
          modifiers = [ "bold" ];
        };
        "ui.help" = {
          fg = "fg";
          bg = "bgSoft";
        };
        "ui.virtual.indent-guide" = "gutter";
        "ui.virtual.ruler" = {
          bg = "bgAlt";
        };
        "ui.virtual.whitespace" = "gutter";
        "ui.virtual.inlay-hint" = "gray";

        # syntax
        "comment" = {
          fg = "gray";
          modifiers = [ "italic" ];
        };
        "variable" = "fg";
        "variable.parameter" = "fgSoft";
        "variable.builtin" = "red";
        "variable.other.member" = "cyan";
        "constant" = "orange";
        "constant.numeric" = "orange";
        "constant.character.escape" = "magenta";
        "string" = "green";
        "string.regexp" = "cyan";
        "type" = "yellow";
        "type.builtin" = "yellow";
        "constructor" = "blue";
        "function" = "blue";
        "function.builtin" = "blue";
        "function.macro" = "magenta";
        "keyword" = {
          fg = "magenta";
        };
        "keyword.control" = "magenta";
        "keyword.directive" = "brown";
        "operator" = "fgSoft";
        "punctuation" = "gray";
        "punctuation.bracket" = "fgSoft";
        "label" = "magenta";
        "namespace" = "cyan";
        "attribute" = "brown";
        "tag" = "blue";

        "markup.heading" = {
          fg = "orange";
          modifiers = [ "bold" ];
        };
        "markup.bold" = {
          modifiers = [ "bold" ];
        };
        "markup.italic" = {
          modifiers = [ "italic" ];
        };
        "markup.link.url" = {
          fg = "cyan";
          modifiers = [ "underlined" ];
        };
        "markup.link.text" = "blue";
        "markup.raw" = "green";

        # diagnostics & diff
        "diagnostic.error" = {
          underline = {
            color = "red";
            style = "curl";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = "yellow";
            style = "curl";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = "blue";
            style = "curl";
          };
        };
        "diagnostic.hint" = {
          underline = {
            color = "cyan";
            style = "curl";
          };
        };
        "error" = "red";
        "warning" = "yellow";
        "info" = "blue";
        "hint" = "cyan";

        "diff.plus" = "green";
        "diff.minus" = "red";
        "diff.delta" = "blue";
      };
    };
}
