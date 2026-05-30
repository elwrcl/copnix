{ ... }:

{
  nixpkgs.overlays = [
    (_: prev: {
      legcord = prev.legcord.overrideAttrs (old: {
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ prev.asar ];

        postInstall = (old.postInstall or "") + ''
          asarFile=$(find $out -name "app.asar" -print -quit)
          asar extract "$asarFile" "$TMPDIR/legcord-src"
          substituteInPlace "$TMPDIR/legcord-src/ts-out/main.js" \
            --replace 'corsEnabled: false,' 'corsEnabled: true,'
          asar pack "$TMPDIR/legcord-src" "$asarFile"
        '';
      });
    })
  ];
}
