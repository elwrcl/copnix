{ ... }:
{
  flake.nixosModules.service-kde-connect =
    { ... }:
    {
      programs.kdeconnect.enable = true;
    };
}
