{ ... }:
{
  flake.nixosModules.service-tumbler =
    { ... }:
    {
      services.tumbler.enable = true;
    };
}
