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
        "ui.window" = "gutter";
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
        "markup.heading.marker" = "brown";
        "markup.list" = "magenta";
        "markup.quote" = {
          fg = "fgSoft";
          modifiers = [ "italic" ];
        };
        "markup.link" = "blue";
        "markup.link.label" = "cyan";
        "markup.raw.inline" = {
          fg = "green";
          bg = "bgAlt";
        };
        "markup.raw.block" = "green";
        "markup.strikethrough" = {
          modifiers = [ "crossed_out" ];
        };

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

        "diagnostic.unnecessary" = {
          modifiers = [ "dim" ];
        };
        "diagnostic.deprecated" = {
          modifiers = [ "crossed_out" ];
        };

        "diff.plus" = "green";
        "diff.minus" = "red";
        "diff.delta" = "blue";
        "diff.plus.gutter" = "green";
        "diff.minus.gutter" = "red";
        "diff.delta.gutter" = "blue";

        # ui — pickers, popups, jump labels
        "ui.highlight" = {
          bg = "bgSoft";
          modifiers = [ "bold" ];
        };
        "ui.highlight.frameline" = {
          bg = "selectPrimary";
        };
        "ui.menu.scroll" = {
          fg = "gray";
          bg = "bgAlt";
        };
        "ui.text.inactive" = "gray";
        "ui.text.info" = "fgSoft";
        "ui.text.directory" = "blue";
        "ui.background.separator" = "gutter";
        "ui.gutter.selected" = {
          bg = "bgAlt";
        };
        "ui.cursorline" = {
          bg = "bgAlt";
        };
        "ui.cursorcolumn.primary" = {
          bg = "bgAlt";
        };

        "ui.picker.header" = {
          fg = "gray";
          modifiers = [ "bold" ];
        };
        "ui.picker.header.column" = "gray";
        "ui.picker.header.column.active" = {
          fg = "orange";
          modifiers = [ "bold" ];
        };

        "ui.virtual" = "gutter";
        # `gw`/`gW` labels were rendering in the underlying token colour.
        "ui.virtual.jump-label" = {
          fg = "bg";
          bg = "orange";
          modifiers = [ "bold" ];
        };
        "ui.virtual.wrap" = "gutter";
        "ui.virtual.inlay-hint.type" = "gray";
        "ui.virtual.inlay-hint.parameter" = "gray";

        # mode-aware cursors, to match `color-modes`
        "ui.cursor.normal" = {
          fg = "bg";
          bg = "fgSoft";
        };
        "ui.cursor.insert" = {
          fg = "bg";
          bg = "green";
        };
        "ui.cursor.select" = {
          fg = "bg";
          bg = "magenta";
        };
        "ui.cursor.primary.normal" = {
          fg = "bg";
          bg = "fgBright";
        };
        "ui.cursor.primary.insert" = {
          fg = "bg";
          bg = "green";
        };
        "ui.cursor.primary.select" = {
          fg = "bg";
          bg = "magenta";
        };

        # dap
        "ui.debug" = "orange";
        "ui.debug.breakpoint" = "red";
        "ui.debug.active" = "yellow";

        "special" = "brown";
      };
    };
}
