{ inputs, ... }:
{
  flake.nixosModules.hw-i915-lab =
    { config, pkgs, ... }:
    {
      specialisation.lab-full-ppgtt.configuration = {
        system.nixos.tags = [ "lab-full-ppgtt" ];
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
      };
    };
}
