{ ... }:
{
  flake.nixosModules.service-docker =
    { ... }:
    {
      virtualisation.docker.enable = true;
    };
}
