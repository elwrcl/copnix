{ ... }:
{
  # sidechery "sidebery" ported to chromium for helium built from source and side-loaded.
  flake.homeModules.home-browser-helium-sidechery =
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:
    let
      sidechery = pkgs.stdenv.mkDerivation (finalAttrs: {
        pname = "sidechery";
        version = (builtins.fromJSON (builtins.readFile "${inputs.sidechery}/package.json")).version;
        src = inputs.sidechery;

        pnpmDeps = pkgs.fetchPnpmDeps {
          inherit (finalAttrs) pname version src;
          pnpm = pkgs.pnpm_10;
          fetcherVersion = 4;
          hash = "sha256-c05e5Wchb3mq45cHcjjiUCAzi9RrhtKWunYJ7QK30wM=";
        };

        nativeBuildInputs = [
          pkgs.nodejs
          pkgs.pnpm_10
          pkgs.pnpmConfigHook
        ];

        buildPhase = ''
          runHook preBuild
          pnpm run build:chrome
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          cp -r .output/chrome-mv3 $out
          runHook postInstall
        '';
      });

      panelColors = [
        "red"
        "orange"
        "yellow"
        "green"
        "cyan"
        "purple"
        "pink"
      ];

      sidechery-styled = pkgs.runCommand "sidechery-styled" { } ''
        cp -r ${sidechery} $out
        chmod -R u+w $out
        cat ${pkgs.writeText "sidechery-extra.css" config.elars.sidechery.extraCss} >> $out/styles/sidebar.css
      '';
    in
    {
      options.elars.sidechery.extraCss = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = ''
          CSS appended to sidechery's sidebar stylesheet at build time, so
          styling doesn't depend on the in-extension styles editor.
        '';
      };
      config.xdg.configFile."sidechery/panels.json".text = builtins.toJSON {
        ver = sidechery.version;
        sidebar = {
          panels = lib.genAttrs panelColors (color: {
            type = 2; # PanelType.tabs
            id = color;
            name = color;
            inherit color;
            iconSVG = "icon_circle";
          });
          nav = panelColors ++ [
            "collapse"
            "settings"
            "create_snapshot"
          ];
        };
      };

      config.programs.helium = {
        extraFlags = [ "--load-extension=${sidechery-styled}" ];

        preferences = {
          helium.browser.layout = 2;
          extensions.commands."linux:Ctrl+S" = {
            command_name = "_execute_action";
            extension = "napehjbogfncaoogcckddbidjgcapclg";
            global = false;
          };
        };
      };
    };
}
