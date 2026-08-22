{ inputs, ... }:
{
  flake.nixosModules.hw-intel-hard =
    { ... }:
    {
      imports = [ inputs.intel-hard.nixosModules.default ];

      programs.intel-hard = {
        enable = true;
        buildRoot = "/mnt/HDD/linuxdata/Projects/Drivers/intel-hard-graphics/build";
        opencl.clvkBuildRoot = "/mnt/HDD/linuxdata/Projects/Drivers/clvk/build";
      };
    };
}
