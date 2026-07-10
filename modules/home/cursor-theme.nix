{ stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "macos27-cursors";
  version = "1.0";
  # bu dosyayla ayni klasorde ./cursors/MacOS27 olmali (flake pure-eval mutlak
  # yollara izin vermiyor, o yuzden relative + flake agacinin icinde olmali)
  src = ./cursors/MacOS27;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/icons/MacOS27
    cp -r $src/* $out/share/icons/MacOS27/
  '';
}
