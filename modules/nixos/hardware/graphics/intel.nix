{
  pkgs,
  ...
}:

{
  hardware.graphics = {
    extraPackages = [
      (pkgs.intel-vaapi-driver.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "irql-notlessorequal";
          repo = "intel-vaapi-driver";
          rev = "929e936ec1f451a5daa12b0c7367687b712b8c2c";
          hash = "sha256-tZ1rZ+4bRxarcFQhP8V2Mfz0sJ5rBgHYLu2ulrQwL+U=";
        };
      }))
      pkgs.libvdpau-va-gl
    ];

    extraPackages32 = [
      (pkgs.pkgsi686Linux.intel-vaapi-driver.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "irql-notlessorequal";
          repo = "intel-vaapi-driver";
          rev = "929e936ec1f451a5daa12b0c7367687b712b8c2c";
          hash = "sha256-tZ1rZ+4bRxarcFQhP8V2Mfz0sJ5rBgHYLu2ulrQwL+U=";
        };
      }))
      pkgs.pkgsi686Linux.libvdpau-va-gl
    ];
  };

  services.xserver.videoDrivers = [ "modesetting" ];
  environment.variables.LIBVA_DRIVER_NAME = "i965";
}