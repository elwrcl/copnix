{ inputs, ... }:
{
  flake.nixosModules.common-agenix = inputs.agenix.nixosModules.default;
  flake.darwinModules.common-agenix = inputs.agenix.darwinModules.default;
}
