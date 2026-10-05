{ ... }:
{
  flake.homeModules.home-mpv =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      cfg = config.elars.mpv;
      withScripts = pkgs.mpv.override {
        mpv-unwrapped =
          if cfg.vapoursynth then
            pkgs.mpv-unwrapped.override { vapoursynthSupport = true; }
          else
            pkgs.mpv-unwrapped;
        scripts = with pkgs.mpvScripts; [
          uosc
          thumbfast
          autoload
          mpris
          memo
          quality-menu
          sponsorblock-minimal
          reload
        ];
      };
    in
    {
      options.elars.mpv.wrapperRun = lib.mkOption {
        type = lib.types.lines;
        default = "";
        description = "Shell snippet run by the mpv wrapper before exec.";
      };

      options.elars.mpv.vapoursynth = lib.mkEnableOption "VapourSynth filter support in mpv";

      config.programs.mpv = {
        enable = true;

        package =
          if cfg.wrapperRun == "" then
            withScripts
          else
            pkgs.symlinkJoin {
              name = "mpv-wrapped";
              paths = [ withScripts ];
              nativeBuildInputs = [ pkgs.makeShellWrapper ];
              postBuild = ''
                wrapProgramShell $out/bin/mpv --run ${lib.escapeShellArg cfg.wrapperRun}
              '';
            };

        config = {
          hwdec = "vulkan,vaapi";
          hwdec-codecs = "all";
          osc = "no";
          osd-bar = "no";
        };
      };
    };
}
