{ ... }:
{
  flake.nixosModules.service-flatpak =
    { ... }:
    {
      services.flatpak.enable = true;
    };
}
