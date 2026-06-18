{ pkgs }:

let
  is32 = pkgs.stdenv.hostPlatform.system == "i686-linux";
  layerName = "VK_LAYER_hasvk14_version_override" + pkgs.lib.optionalString is32 "_32";
in

pkgs.stdenv.mkDerivation {
  name = "vulkan-layer-hasvk14" + pkgs.lib.optionalString is32 "-32bit";
  src = ./.;

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
      --subst-var out \
      --subst-var-by layer_name "${layerName}"
  '';
}
