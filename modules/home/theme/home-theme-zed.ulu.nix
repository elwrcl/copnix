{ ... }:
{
  flake.homeModules.home-theme-zed =
    { config, lib, ... }:
    let
      toHex =
        n:
        let
          digits = "0123456789abcdef";
          c =
            if n < 0 then
              0
            else if n > 255 then
              255
            else
              n;
        in
        builtins.substring (c / 16) 1 digits + builtins.substring (lib.mod c 16) 1 digits;
      lift =
        pct: hex: "#" + lib.concatMapStrings (c: toHex (c * pct / 100)) (config.elars.theme.hexToRgb hex);

      # Same roles as home-theme-vscode. Accents are lifted on dark
      # backgrounds only; lifting them on the light variant loses contrast.
      theme =
        {
          name,
          appearance,
          palette,
          vivid,
        }:
        let
          p = palette.withHashtag;

          bg = p.base00;
          bgAlt = p.base01;
          bgSoft = p.base02;
          gutter = p.base03;
          gray = lift vivid p.base04;
          fg = p.base05;
          fgSoft = p.base06;
          fgBright = p.base07;
          red = lift vivid p.base08;
          orange = lift vivid p.base09;
          yellow = lift vivid p.base0A;
          green = lift vivid p.base0B;
          cyan = lift vivid p.base0C;
          blue = lift vivid p.base0D;
          magenta = lift vivid p.base0E;
          brown = lift (if vivid > 100 then 175 else 100) p.base0F;

          none = "#00000000";
          sel = "${blue}66";
          find = "${yellow}4d";
          word = "${gray}33";
          wordStrong = "${gray}4d";

          color = c: { color = c; };
          italic = c: {
            color = c;
            font_style = "italic";
          };
          bold = c: {
            color = c;
            font_weight = 700;
          };
        in
        {
          inherit name appearance;
          style = {
            background = bg;
            "surface.background" = bg;
            "elevated_surface.background" = bgAlt;
            "panel.background" = bg;
            "panel.focused_border" = gutter;
            "pane.focused_border" = gutter;
            "pane_group.border" = bgAlt;
            "drop_target.background" = "${bgSoft}80";

            border = bgAlt;
            "border.variant" = bgAlt;
            "border.focused" = gutter;
            "border.selected" = gutter;
            "border.transparent" = none;
            "border.disabled" = bgAlt;

            "element.background" = bgAlt;
            "element.hover" = bgSoft;
            "element.active" = gutter;
            "element.selected" = bgSoft;
            "element.disabled" = bgAlt;
            "ghost_element.background" = none;
            "ghost_element.hover" = bgAlt;
            "ghost_element.active" = bgSoft;
            "ghost_element.selected" = bgSoft;
            "ghost_element.disabled" = none;

            text = fg;
            "text.muted" = gray;
            "text.placeholder" = gutter;
            "text.disabled" = gutter;
            "text.accent" = orange;
            icon = fgSoft;
            "icon.muted" = gray;
            "icon.disabled" = gutter;
            "icon.placeholder" = gutter;
            "icon.accent" = orange;
            "link_text.hover" = cyan;

            # chrome — ui.statusline / ui.bufferline
            "title_bar.background" = bg;
            "title_bar.inactive_background" = bg;
            "toolbar.background" = bg;
            "status_bar.background" = bgSoft;
            "tab_bar.background" = bg;
            "tab.inactive_background" = bgAlt;
            "tab.active_background" = bgSoft;
            "scrollbar.thumb.background" = "${bgSoft}80";
            "scrollbar.thumb.hover_background" = gutter;
            "scrollbar.thumb.border" = none;
            "scrollbar.track.background" = none;
            "scrollbar.track.border" = none;

            # editor — ui.background / ui.cursor / ui.selection / ui.linenr
            "editor.background" = bg;
            "editor.foreground" = fg;
            "editor.gutter.background" = bg;
            "editor.subheader.background" = bgAlt;
            "editor.active_line.background" = bgAlt;
            "editor.highlighted_line.background" = bgAlt;
            "editor.line_number" = gutter;
            "editor.active_line_number" = orange;
            "editor.invisible" = bgSoft;
            "editor.wrap_guide" = bgAlt;
            "editor.active_wrap_guide" = bgAlt;
            "editor.indent_guide" = bgSoft;
            "editor.indent_guide_active" = gutter;
            "editor.document_highlight.read_background" = word;
            "editor.document_highlight.write_background" = wordStrong;
            "search.match_background" = find;

            # diagnostics / vcs
            error = red;
            "error.background" = "${red}1a";
            "error.border" = red;
            warning = yellow;
            "warning.background" = "${yellow}1a";
            "warning.border" = yellow;
            info = blue;
            "info.background" = "${blue}1a";
            "info.border" = blue;
            hint = cyan;
            "hint.background" = "${cyan}1a";
            "hint.border" = cyan;
            success = green;
            created = green;
            "created.background" = "${green}1a";
            modified = blue;
            "modified.background" = "${blue}1a";
            deleted = red;
            "deleted.background" = "${red}1a";
            conflict = orange;
            renamed = cyan;
            ignored = gutter;
            hidden = gutter;
            unreachable = gray;
            predictive = gutter;

            # terminal — same 16 as home-theme-ghostty
            "terminal.background" = bg;
            "terminal.foreground" = fg;
            "terminal.bright_foreground" = fgBright;
            "terminal.dim_foreground" = gray;
            "terminal.ansi.black" = bg;
            "terminal.ansi.red" = red;
            "terminal.ansi.green" = green;
            "terminal.ansi.yellow" = yellow;
            "terminal.ansi.blue" = blue;
            "terminal.ansi.magenta" = magenta;
            "terminal.ansi.cyan" = cyan;
            "terminal.ansi.white" = fg;
            "terminal.ansi.bright_black" = gutter;
            "terminal.ansi.bright_red" = red;
            "terminal.ansi.bright_green" = green;
            "terminal.ansi.bright_yellow" = orange;
            "terminal.ansi.bright_blue" = blue;
            "terminal.ansi.bright_magenta" = magenta;
            "terminal.ansi.bright_cyan" = cyan;
            "terminal.ansi.bright_white" = fgBright;

            players = [
              {
                cursor = fgBright;
                background = fgBright;
                selection = sel;
              }
            ];

            syntax = {
              attribute = color brown;
              boolean = color orange;
              comment = italic gray;
              "comment.doc" = italic gray;
              constant = color orange;
              constructor = color blue;
              embedded = color fg;
              emphasis.font_style = "italic";
              "emphasis.strong".font_weight = 700;
              enum = color yellow;
              function = color blue;
              "function.macro" = color magenta;
              keyword = color magenta;
              label = color magenta;
              lifetime = color magenta;
              link_text = italic cyan;
              link_uri = color cyan;
              number = color orange;
              operator = color fgSoft;
              preproc = color brown;
              primary = color fg;
              property = color cyan;
              punctuation = color gray;
              "punctuation.bracket" = color fgSoft;
              "punctuation.delimiter" = color gray;
              "punctuation.list_marker" = color magenta;
              "punctuation.special" = color magenta;
              string = color green;
              "string.escape" = color magenta;
              "string.regex" = color cyan;
              "string.special" = color magenta;
              "string.special.symbol" = color orange;
              tag = color blue;
              "text.literal" = color green;
              title = bold orange;
              type = color yellow;
              variable = color fg;
              "variable.parameter" = color fgSoft;
              "variable.special" = color red; # self
              variant = color orange;
            };
          };
        };
    in
    {
      programs.zed-editor = {
        themes.copland = {
          "$schema" = "https://zed.dev/schema/themes/v0.2.0.json";
          name = "Copland";
          author = "elars";
          themes = [
            (theme {
              name = "Copland Dark";
              appearance = "dark";
              palette = config.elars.theme.palette;
              vivid = 125;
            })
            (theme {
              name = "Copland Light";
              appearance = "light";
              palette = config.elars.theme.paletteLight;
              vivid = 100;
            })
          ];
        };

        # Follows the desktop's light/dark preference (noctalia's mode).
        userSettings.theme = {
          mode = "system";
          dark = "Copland Dark";
          light = "Copland Light";
        };
      };
    };
}
