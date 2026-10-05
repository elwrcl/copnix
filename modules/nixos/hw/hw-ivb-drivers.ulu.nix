{ ... }:
{
  flake.nixosModules.hw-ivb-drivers =
    { pkgs, ... }:
    let
      drivers =
        p: arch:
        p.stdenv.mkDerivation {
          pname = "ivb-drivers";
          version = "fork";
          src = ../../../drivers/ivb + "/${arch}";

          nativeBuildInputs = [ p.autoPatchelfHook ];
          buildInputs = with p; [
            libdrm
            zstd
            expat
            libxcb
            libx11
            libxshmfence
            xcbutilkeysyms
            wayland
            llvmPackages_21.llvm.lib
            llvmPackages_21.libclang.lib
            spirv-llvm-translator
            stdenv.cc.cc.lib
          ];
          dontStrip = true; # stripped by meson install

          installPhase = ''
            runHook preInstall
            mkdir -p $out/lib/d3d $out/share/vulkan/icd.d
            install -m 0755 libvulkan_intel_hasvk13.so $out/lib/
            install -m 0755 d3dadapter9.so.1 $out/lib/d3d/
            ln -s d3dadapter9.so.1 $out/lib/d3d/d3dadapter9.so

            cat > $out/share/vulkan/icd.d/intel_hasvk_ivb_icd.${arch}.json <<EOF
            {
                "ICD": {
                    "api_version": "1.3.352",
                    "library_arch": "${if arch == "x86_64" then "64" else "32"}",
                    "library_path": "$out/lib/libvulkan_intel_hasvk13.so"
                },
                "file_format_version": "1.0.1"
            }
            EOF

            if [ -f libRusticlOpenCL.so.1 ]; then
              install -m 0755 libRusticlOpenCL.so.1 $out/lib/
              mkdir -p $out/etc/OpenCL/vendors
              echo $out/lib/libRusticlOpenCL.so.1 > $out/etc/OpenCL/vendors/rusticl-ivb.icd
            fi
            runHook postInstall
          '';
        };

      withoutHasvk =
        mesa:
        pkgs.symlinkJoin {
          name = "${mesa.name}-without-hasvk";
          paths = [ mesa ];
          postBuild = ''
            rm -f $out/share/vulkan/icd.d/intel_hasvk_icd.*.json
          '';
        };

      # pocl with the gen7 device (OpenCL on the HD 4000) and the host CPU
      # device, from Drivers/pocl-gen7/release.sh. The gen7 device finds
      # libgbe and beignet's library in lib/beignet next to itself.
      pocl-gen7 = pkgs.stdenv.mkDerivation {
        pname = "pocl-gen7";
        version = "release";
        src = ../../../drivers/pocl-gen7;

        nativeBuildInputs = [ pkgs.autoPatchelfHook ];
        buildInputs = with pkgs; [
          libdrm
          hwloc
          zlib
          zstd
          libxml2
          llvmPackages_21.llvm.lib
          llvmPackages_21.clang-unwrapped.lib # libgbe: libclang-cpp
          stdenv.cc.cc.lib
        ];
        dontStrip = true; # stripped by release.sh

        installPhase = ''
          runHook preInstall
          mkdir -p $out/etc/OpenCL/vendors
          cp -a lib share $out/
          echo $out/lib/libpocl.so.2 > $out/etc/OpenCL/vendors/pocl-gen7.icd
          runHook postInstall
        '';
      };
    in
    {
      hardware.graphics = {
        package = withoutHasvk pkgs.mesa;
        package32 = withoutHasvk pkgs.pkgsi686Linux.mesa;
        extraPackages = [
          (drivers pkgs "x86_64")
          pocl-gen7
        ];
        extraPackages32 = [ (drivers pkgs.pkgsi686Linux "i686") ];
      };
      # sessionVariables: set through PAM for the whole session, so every
      # shell (nushell too) and every program started from it sees them
      environment.sessionVariables = {
        RUSTICL_ENABLE = "crocus";
        # pocl builds basic and pthread (both the CPU); the GPU comes first
        POCL_DEVICES = "gen7 pthread";
      };
    };
}
