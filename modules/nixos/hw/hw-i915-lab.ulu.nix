{ inputs, ... }:
{
  flake.nixosModules.hw-i915-lab =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.elars.i915Lab.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Patched i915 from gen7-ppgtt-lab: full PPGTT, trampoline fix, render busyness.";
      };

      config = lib.mkMerge [
        (lib.mkIf config.elars.i915Lab.enable {
          boot.extraModulePackages = [
            (inputs.gen7-ppgtt-lab.lib.i915ForKernel {
              inherit pkgs;
              kernelPackages = config.boot.kernelPackages;
            })
          ];
          boot.kernelParams = [
            "i915.lab_full_ppgtt=1"
            "i915.lab_c1=1"
            "i915.lab_k0=1"
            "i915.lab_pdlog=0"
            "i915.lab_tramp_direct=1"
            "i915.lab_busy=1"
          ];
        })
        {
          # fallback.
          specialisation.stock-i915.configuration = {
            system.nixos.tags = [ "stock-i915" ];
            elars.i915Lab.enable = false;
          };
        }
      ];
    };
}
