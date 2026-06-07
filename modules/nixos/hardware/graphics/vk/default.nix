{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "vulkan-layer-hasvk14";
  src  = ./.;

  buildInputs = [ pkgs.vulkan-headers ];

  buildPhase = ''
    $CC -shared -fPIC -O2 -o libVkLayer_hasvk14.so hasvk14_layer.c \
      -I${pkgs.vulkan-headers}/include
  '';

  installPhase = ''
    mkdir -p $out/lib $out/share/vulkan/implicit_layer.d
    cp libVkLayer_hasvk14.so $out/lib/

    substitute hasvk14_layer.json \
      $out/share/vulkan/implicit_layer.d/hasvk14_layer.json \
      --subst-var out
  '';
}
