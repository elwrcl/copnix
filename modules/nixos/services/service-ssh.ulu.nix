{ ... }:
{
  flake.nixosModules.service-ssh =
    { ... }:
    {
      services.openssh.enable = true;
      services.tailscale.enable = true;
    };
}
