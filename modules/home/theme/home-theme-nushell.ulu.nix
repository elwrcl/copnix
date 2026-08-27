{ ... }:
{
  flake.homeModules.home-theme-nushell =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (lib.meta) getExe;

      p = config.elars.theme.palette;
      h = p.withHashtag;
      accent = h.accent or h.base06;

      vividTheme = pkgs.writeText "kemuri.yml" ''
        colors:
          bg: '${p.base00}'
          surface: '${p.base02}'
          muted: '${p.base04}'
          fg: '${p.base05}'
          accent: '${lib.removePrefix "#" accent}'
          red: '${p.base08}'
          orange: '${p.base09}'
          yellow: '${p.base0A}'
          green: '${p.base0B}'
          cyan: '${p.base0C}'
          blue: '${p.base0D}'
          magenta: '${p.base0E}'
          brown: '${p.base0F}'

        core:
          normal_text: {}
          regular_file: {}
          reset_to_normal: {}

          directory:
            foreground: blue
            font-style: bold

          symlink:
            foreground: cyan

          multi_hard_link: {}

          fifo:
            foreground: bg
            background: cyan

          socket:
            foreground: bg
            background: magenta

          door:
            foreground: bg
            background: magenta

          block_device:
            foreground: bg
            background: orange

          character_device:
            foreground: bg
            background: yellow

          broken_symlink:
            foreground: bg
            background: red

          missing_symlink_target:
            foreground: bg
            background: red

          setuid:
            foreground: red
            font-style: bold

          setgid:
            foreground: orange
            font-style: bold

          file_with_capability:
            foreground: red

          sticky_other_writable:
            foreground: bg
            background: green

          other_writable:
            foreground: blue
            background: surface

          sticky:
            foreground: bg
            background: blue

          executable_file:
            foreground: green
            font-style: bold

        text:
          special:
            foreground: bg
            background: accent

          todo:
            font-style: bold

          licenses:
            foreground: muted

          configuration:
            foreground: yellow

          other:
            foreground: fg

        markup:
          foreground: accent

        programming:
          source:
            foreground: cyan

          tooling:
            foreground: brown

            continuous-integration:
              foreground: magenta

        media:
          foreground: magenta

        office:
          foreground: orange

        archives:
          foreground: red
          font-style: underline

        executable:
          foreground: green
          font-style: bold

        unimportant:
          foreground: muted
      '';

      lsColors = pkgs.runCommand "ls_colors.txt" { } ''
        ${getExe pkgs.vivid} generate ${vividTheme} > $out
      '';
    in
    {
      home.packages = [ pkgs.vivid ];

      programs.nushell.extraConfig = ''
        $env.LS_COLORS = open --raw ${lsColors}

        $env.config.color_config = {
          separator: "${h.base03}"
          leading_trailing_space_bg: { attr: n }
          header: { fg: "${accent}" attr: b }
          row_index: { fg: "${h.base04}" attr: b }
          empty: "${h.base0D}"
          hints: "${h.base04}"
          search_result: { fg: "${h.base00}" bg: "${accent}" }

          int: "${h.base09}"
          float: "${h.base09}"
          filesize: "${h.base0C}"
          duration: "${h.base0A}"
          datetime: "${h.base0E}"
          range: "${h.base0A}"
          binary: "${h.base0F}"
          nothing: "${h.base08}"
          cell-path: "${h.base06}"
          record: "${h.base05}"
          list: "${h.base05}"
          block: "${h.base05}"
          closure: "${h.base0C}"
          glob: "${h.base0C}"

          shape_binary: { fg: "${h.base0F}" attr: b }
          shape_block: { fg: "${h.base0D}" attr: b }
          shape_bool: "${h.base0C}"
          shape_closure: { fg: "${h.base0C}" attr: b }
          shape_custom: "${h.base0B}"
          shape_datetime: { fg: "${h.base0E}" attr: b }
          shape_directory: "${h.base0D}"
          shape_external: "${h.base0C}"
          shape_external_resolved: { fg: "${h.base0B}" attr: b }
          shape_externalarg: { fg: "${h.base0B}" attr: b }
          shape_filepath: "${h.base0D}"
          shape_flag: { fg: "${h.base0A}" attr: b }
          shape_float: { fg: "${h.base09}" attr: b }
          shape_garbage: { fg: "${h.base07}" bg: "${h.base08}" attr: b }
          shape_glob_interpolation: { fg: "${h.base0C}" attr: b }
          shape_globpattern: { fg: "${h.base0C}" attr: b }
          shape_int: { fg: "${h.base09}" attr: b }
          shape_internalcall: { fg: "${h.base0C}" attr: b }
          shape_keyword: { fg: "${h.base0E}" attr: b }
          shape_list: { fg: "${h.base0C}" attr: b }
          shape_literal: "${h.base0D}"
          shape_match_pattern: "${h.base0B}"
          shape_matching_brackets: { attr: u }
          shape_nothing: "${h.base08}"
          shape_operator: "${h.base0A}"
          shape_pipe: { fg: "${h.base0E}" attr: b }
          shape_range: { fg: "${h.base0A}" attr: b }
          shape_record: { fg: "${h.base0C}" attr: b }
          shape_redirection: { fg: "${h.base0E}" attr: b }
          shape_signature: { fg: "${h.base0B}" attr: b }
          shape_string: "${h.base0B}"
          shape_string_interpolation: { fg: "${h.base0C}" attr: b }
          shape_table: { fg: "${h.base0D}" attr: b }
          shape_variable: "${h.base0E}"
          shape_vardecl: "${h.base0E}"
        }

        $env.config.color_config.bool = {||
          if $in {
            { fg: "${h.base0B}" attr: b }
          } else {
            { fg: "${h.base08}" attr: b }
          }
        }

        $env.config.color_config.string = {||
          if $in =~ "^(#|0x)[a-fA-F0-9]+$" {
            $in | str replace "0x" "#"
          } else {
            "${h.base05}"
          }
        }
      '';
    };
}
