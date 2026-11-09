{ ... }:
{
  flake.homeModules.home-font-obel-mono =
    { pkgs, ... }:
    let
      obel-mono = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
        pname = "obel-mono";
        version = "1.002";
        src = pkgs.fetchzip {
          url = "https://typographic.systems/download/ObelMono-${finalAttrs.version}-ttf.zip";
          hash = "sha256-wgZbh1eSb26Qy/Zj8J38/KNmnZkDGmQ3JXzaeUvz3Hw=";
        };

        installPhase = ''
          runHook preInstall
          install -Dm644 -t $out/share/fonts/truetype static/*.ttf
          runHook postInstall
        '';

        meta = {
          homepage = "https://typographic.systems/obel-mono";
          license = pkgs.lib.licenses.ofl;
          platforms = pkgs.lib.platforms.all;
        };
      });
    in
    {
      home.packages = [ obel-mono ];
    };
}
