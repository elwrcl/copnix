{ inputs, ... }:
{
  flake.nixosModules.common-agenix = inputs.agenix.nixosModules.default;
}
