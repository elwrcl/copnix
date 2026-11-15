{ inputs, ... }:
{
  flake.nixosModules.common-bootvine =
    { ... }:
    {
      imports = [ inputs.bootvine.nixosModules.default ];

      services.bootvine.enable = true;
    };
}
