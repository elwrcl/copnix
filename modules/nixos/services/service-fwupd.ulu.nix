{ ... }:
{
  flake.nixosModules.service-fwupd =
    { ... }:
    {
      services.fwupd.enable = true;
    };
}
