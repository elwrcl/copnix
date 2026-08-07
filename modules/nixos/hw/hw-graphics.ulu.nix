{ ... }:
{
  flake.nixosModules.hw-graphics =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      driver = config.elars.hardware.graphics.driver;

      amd = {
        hardware.graphics.extraPackages = with pkgs; [
          rocmPackages.clr.icd
        ];

        services.xserver.videoDrivers = [ "amdgpu" ];
      };

      intel =
        let
          wayland-intel-vaapi-driver = pkgs.intel-vaapi-driver.overrideAttrs (oldAttrs: {
            version = "2.4.4-wayland-fix";
            src = pkgs.fetchFromGitHub {
              owner = "irql-notlessorequal";
              repo = "intel-vaapi-driver";
              rev = "929e936ec1f451a5daa12b0c7367687b712b8c2c";
              hash = "sha256-tZ1rZ+4bRxarcFQhP8V2Mfz0sJ5rBgHYLu2ulrQwL+U=";
            };
          });
          wayland-intel-vaapi-driver-32 = pkgs.pkgsi686Linux.intel-vaapi-driver.overrideAttrs (oldAttrs: {
            version = "2.4.4-wayland-fix";
            src = pkgs.fetchFromGitHub {
              owner = "irql-notlessorequal";
              repo = "intel-vaapi-driver";
              rev = "929e936ec1f451a5daa12b0c7367687b712b8c2c";
              hash = "sha256-tZ1rZ+4bRxarcFQhP8V2Mfz0sJ5rBgHYLu2ulrQwL+U=";
            };

          });
          #hasvk14-layer = pkgs.callPackage ./vk { };
          #hasvk14-layer-32 = pkgs.pkgsi686Linux.callPackage ./vk { };
        in
        {
          hardware.graphics = {
            extraPackages = [
              #hasvk14-layer
              wayland-intel-vaapi-driver
              pkgs.libvdpau-va-gl
              pkgs.pocl
            ];
            extraPackages32 = [
              #hasvk14-layer-32
              wayland-intel-vaapi-driver-32
              pkgs.pkgsi686Linux.libvdpau-va-gl
            ];
          };
          services.xserver.videoDrivers = [ "modesetting" ];
          environment.variables = {
            LIBVA_DRIVER_NAME = "i965";
          };
        };

      nvidia = {
        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.nvidia = {
          modesetting.enable = true;
          open = false;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
      };

      prime = {
        hardware.nvidia.prime = {
          offload.enable = true;
          amdgpuBusId = "PCI:X:X:X";
          nvidiaBusId = "PCI:X:X:X";
        };
      };
    in
    {
      options.elars.hardware.graphics.driver = lib.mkOption {
        type = lib.types.enum [
          "intel"
          "amd"
          "nvidia"
          "hybrid-amd-nvidia"
        ];
        default = "intel";
      };

      config = lib.mkMerge [
        {
          hardware.graphics = {
            enable = true;
            enable32Bit = true;
          };
        }

        (lib.mkIf (driver == "intel") intel)
        (lib.mkIf (driver == "amd") amd)
        (lib.mkIf (driver == "nvidia") nvidia)
        (lib.mkIf (driver == "hybrid-amd-nvidia") (
          lib.mkMerge [
            amd
            nvidia
            prime
          ]
        ))
      ];
    };
}
