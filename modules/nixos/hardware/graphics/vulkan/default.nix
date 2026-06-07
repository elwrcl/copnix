{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "vulkan-layer-hasvk13";
  src  = ./.;

  buildInputs = [ pkgs.vulkan-headers ];

  buildPhase = ''
    $CC -shared -fPIC -O2 -o libVkLayer_hasvk13.so hasvk13_layer.c \
      -I${pkgs.vulkan-headers}/include
  '';

  installPhase = ''
    mkdir -p $out/lib $out/share/vulkan/implicit_layer.d
    cp libVkLayer_hasvk13.so $out/lib/

    substitute hasvk13_layer.json \
      $out/share/vulkan/implicit_layer.d/hasvk13_layer.json \
      --subst-var out
  '';
}
