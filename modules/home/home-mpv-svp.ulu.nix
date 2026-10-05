{ ... }:
{
  flake.homeModules.home-mpv-svp =
    { pkgs, ... }:
    let
      # Only the free SVPflow plugins are taken from the SVP 4 bundle;
      # the paid SVP Manager is not used.
      svpflow = pkgs.stdenv.mkDerivation (finalAttrs: {
        pname = "svpflow";
        version = "4.7.305";
        src = pkgs.fetchurl {
          url = "https://www.svp-team.com/files/svp4-linux.${finalAttrs.version}.tar.bz2";
          hash = "sha256-PWAcm/hIA4JH2QtJPP+gSJdJLRdfdbZXIVdWELazbxQ=";
        };

        nativeBuildInputs = [
          pkgs.p7zip
          pkgs.autoPatchelfHook
        ];
        buildInputs = [ (pkgs.lib.getLib pkgs.stdenv.cc.cc) ];

        unpackPhase = ''
          tar xf $src
        '';

        # The .run installer is a stack of 7z archives; extract them all.
        buildPhase = ''
          mkdir installer extracted
          LANG=C grep --only-matching --byte-offset --binary --text $'7z\xBC\xAF\x27\x1C' svp4-linux.run |
            cut -f1 -d: |
            while read ofs; do
              dd if=svp4-linux.run bs=1M iflag=skip_bytes status=none skip=$ofs of="installer/bin-$ofs.7z"
            done
          for f in installer/*.7z; do
            7z -bd -bb0 -y x -oextracted "$f" || true
          done
        '';

        installPhase = ''
          install -Dm755 -t $out/lib extracted/plugins/libsvpflow1.so extracted/plugins/libsvpflow2.so
        '';

        meta.license = pkgs.lib.licenses.unfree;
      });

      script = pkgs.writeText "svp.vpy" ''
        import vapoursynth as vs

        core = vs.core
        core.std.LoadPlugin("${svpflow}/lib/libsvpflow1.so")
        core.std.LoadPlugin("${svpflow}/lib/libsvpflow2.so")

        clip = video_in
        src_fps = container_fps if container_fps > 0.1 else 23.976

        if clip.format.id != vs.YUV420P8:
            clip = clip.resize.Point(format=vs.YUV420P8, dither_type="ordered")

        if clip.height > 720:
            clip = clip.resize.Bilinear(round(clip.width * 720 / clip.height / 2) * 2, 720)

        sup = core.svp1.Super(clip, "{pel:1,gpu:1}")
        vec = core.svp1.Analyse(
            sup["clip"], sup["data"], clip,
            "{block:{w:32,h:32,overlap:0},main:{search:{coarse:{distance:0}}},refine:[{thsad:200}]}",
        )
        smooth = core.svp2.SmoothFps(
            clip, sup["clip"], sup["data"], vec["clip"], vec["data"],
            "{rate:{num:60,den:1,abs:true},algo:13,scene:{}}", src=clip, fps=src_fps,
        )
        smooth.set_output()
      '';
    in
    {
      elars.mpv.vapoursynth = true;

      programs.mpv = {
        profiles.svp = {
          profile-cond = ''get("user-data/svp", "yes") == "yes" and get("container-fps", 0) < 40'';
          profile-restore = "copy";
          hwdec = "vaapi";
          scale = "bicubic";
          deinterlace = "auto";
          vf-add = "lavfi=[scale_vaapi=w=-2:h='min(720,ih)':format=nv12,hwdownload,format=nv12],vapoursynth=${script}:buffered-frames=4:concurrent-frames=4";
        };
      };

      xdg.configFile."mpv/scripts/svp-toggle.lua".text = ''
        mp.set_property_native("user-data/svp", "yes")
        mp.add_key_binding("alt+s", "svp-toggle", function()
          local on = mp.get_property_native("user-data/svp") ~= "yes"
          mp.set_property_native("user-data/svp", on and "yes" or "no")
          mp.osd_message("SVP: " .. (on and "on" or "off"))
        end)
      '';
    };
}
