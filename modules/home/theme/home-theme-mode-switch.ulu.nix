{ ... }:
{
  flake.homeModules.home-theme-mode-switch =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      variants = "${config.xdg.configHome}/elars-theme";
      current = "${config.xdg.stateHome}/elars-theme/current";

      switch = pkgs.writeShellScript "elars-theme-mode" ''
        mode="''${1:-''${NOCTALIA_THEME_MODE:-dark}}"
        [ "$mode" = light ] || mode=dark
        ${lib.getExe' pkgs.coreutils "mkdir"} -p "$(${lib.getExe' pkgs.coreutils "dirname"} ${lib.escapeShellArg current})"
        ${lib.getExe' pkgs.coreutils "ln"} -sfn ${lib.escapeShellArg variants}/"$mode" ${lib.escapeShellArg current}
      '';
    in
    {
      options.elars.theme.currentVariantDir = lib.mkOption {
        type = lib.types.str;
        readOnly = true;
        default = current;
        description = ''
          Directory holding the active variant's files; point configs here
          instead of at a fixed dark/light file.
        '';
      };

      config = {
        programs.noctalia.settings.hooks.theme_mode_changed = "${switch}";

        home.activation.elarsThemeMode = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if [ ! -e ${lib.escapeShellArg current} ]; then
            run ${switch} ${config.programs.noctalia.settings.theme.mode or "dark"}
          fi
        '';
      };
    };
}
