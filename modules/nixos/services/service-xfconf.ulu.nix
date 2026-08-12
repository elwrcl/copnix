{ ... }:
{
  flake.nixosModules.service-xfconf =
    { ... }:
    {
      programs.xfconf.enable = true;
    };
}
