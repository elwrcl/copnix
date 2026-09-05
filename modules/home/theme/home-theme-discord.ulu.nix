{ ... }:
{
  # system24 kemuri susu generated
  flake.homeModules.home-theme-discord =
    { config, lib, ... }:
    let
      p = config.elars.theme.palette.withHashtag;
      lighten = c: pct: "color-mix(in oklab, white ${toString pct}%, ${c})";
      darken = c: pct: "color-mix(in oklab, black ${toString pct}%, ${c})";
      ramp =
        indent: name: base:
        lib.concatMapStringsSep "\n${indent}" (x: x) [
          "--${name}-1: ${lighten base 12};"
          "--${name}-2: ${base};"
          "--${name}-3: ${darken base 8};"
          "--${name}-4: ${darken base 16};"
          "--${name}-5: ${darken base 24};"
        ];

      rgb = hex: builtins.concatStringsSep " " (map toString (config.elars.theme.hexToRgb hex));
      accentRgb = rgb (config.elars.theme.palette.accent or config.elars.theme.palette.base06);
      textRgb = rgb config.elars.theme.palette.base05;
      light = {
        surface = "#d4c1a8";
        surfaceVariant = "#c5b29a";
        outline = "#a89682";
        onSurface = "#262524";
        secondary = "#736c5f";
        tertiary = "#594f46";
        error = "#bc4747";
      };

      colors = ''
        /* ── generated from elars.theme.palette ─────────────────────── */
        :root {
            color-scheme: dark;
            --colors: on;

            /* text colors */
            --text-0: var(--bg-4);
            --text-1: ${p.base05};
            --text-2: ${darken p.base05 6};
            --text-3: ${p.base06};
            --text-4: ${lighten p.base04 18};
            --text-5: ${p.base04};

            /* background colors */
            --bg-1: ${lighten p.base02 8};
            --bg-2: ${p.base02};
            --bg-3: ${p.base01};
            --bg-4: ${p.base00};
            --hover: rgb(${accentRgb} / 0.1);
            --active: rgb(${accentRgb} / 0.2);
            --active-2: rgb(${accentRgb} / 0.3);
            --message-hover: var(--hover);

            /* accent colors */
            --accent-1: var(--accent-c-1);
            --accent-2: var(--accent-c-2);
            --accent-3: var(--accent-c-3);
            --accent-4: var(--accent-c-4);
            --accent-5: var(--accent-c-5);
            --accent-new: var(--red-2);
            --mention: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 90%) 40%, transparent);
            --mention-hover: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 95%) 40%, transparent);
            --reply: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 90%) 40%, transparent);
            --reply-hover: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 95%) 40%, transparent);

            /* status indicators */
            --online: var(--green-2);
            --dnd: var(--red-2);
            --idle: var(--yellow-2);
            --streaming: var(--purple-2);
            --offline: var(--text-4);

            /* borders */
            --border-light: var(--hover);
            --border: var(--active);
            --border-hover: var(--accent-2);
            --button-border: rgb(${textRgb} / 0.1);

            /* base ramps */
            ${ramp "    " "accent-c" (p.accent or p.base06)}
            ${ramp "    " "red" p.base08}
            ${ramp "    " "green" p.base0B}
            ${ramp "    " "blue" p.base0D}
            ${ramp "    " "yellow" p.base0A}
            ${ramp "    " "purple" p.base0E}
            ${ramp "    " "cyan" p.base0C}
        }

        @media (prefers-color-scheme: light) {
            :root {
                color-scheme: light;

                --text-0: var(--bg-4);
                --text-1: ${light.onSurface};
                --text-2: ${lighten light.onSurface 6};
                --text-3: ${lighten light.onSurface 12};
                --text-4: ${light.secondary};
                --text-5: ${lighten light.secondary 12};

                --bg-1: ${light.outline};
                --bg-2: ${darken light.surfaceVariant 6};
                --bg-3: ${light.surfaceVariant};
                --bg-4: ${light.surface};
                --hover: rgb(38 37 36 / 0.08);
                --active: rgb(38 37 36 / 0.16);
                --active-2: rgb(38 37 36 / 0.24);
                --message-hover: var(--hover);

                ${ramp "        " "accent-c" light.tertiary}
                --accent-1: var(--accent-c-2);
                --accent-2: var(--accent-c-2);
                --accent-3: var(--accent-c-2);
                --accent-4: var(--accent-c-3);
                --accent-5: var(--accent-c-4);
                --border-hover: var(--accent-c-2);
                --button-border: rgb(38 37 36 / 0.12);
                --mention: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 85%) 40%, transparent);
                --mention-hover: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 92%) 40%, transparent);

                ${ramp "        " "red" light.error}
                ${ramp "        " "green" (darken p.base0B 28)}
                ${ramp "        " "yellow" (darken p.base0A 28)}
                ${ramp "        " "purple" (darken p.base0E 28)}
                ${ramp "        " "blue" (darken p.base0D 28)}

                --online: var(--green-3);
                --dnd: var(--red-3);
                --idle: var(--yellow-3);
                --streaming: var(--purple-3);
                --offline: var(--text-5);
            }
        }
      '';
    in
    {
      xdg.configFile."legcord/quickCss.css".text = ''
        ${builtins.readFile ./discord-system24.css}
        ${colors}
      '';
    };
}
