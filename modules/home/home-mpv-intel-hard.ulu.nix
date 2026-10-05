{ ... }:
{
  flake.homeModules.home-mpv-intel-hard =
    {
      lib,
      pkgs,
      inputs,
      osConfig,
      ...
    }:
    let
      cfg = osConfig.programs.intel-hard;
      vk = (import "${inputs.intel-hard}/graphics").${cfg.vulkan.driver};
      icd = "${cfg.buildRoot}/${vk.icd}";
      runtimeLibPath = lib.makeLibraryPath (import "${inputs.intel-hard}/lib/runtime-libs.nix" pkgs);
    in
    {
      elars.mpv.wrapperRun = lib.mkIf cfg.enable ''
        if [ -f "${icd}" ]; then
          export VK_DRIVER_FILES="${icd}"
          export VK_ICD_FILENAMES="${icd}"
          export MESA_VK_DEVICE_SELECT="${cfg.pciId}"
          export LD_LIBRARY_PATH="${runtimeLibPath}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
          unset MESA_GL_VERSION_OVERRIDE
        fi
      '';
    };
}
