{ inputs, ... }:
{
  flake.nixosModules.hw-intel-hard =
    { ... }:
    {
      imports = [ inputs.intel-hard.nixosModules.default ];
      programs.intel-hard.enable = true;
    };
}
