{ ... }:
{
  flake.nixosModules.net-localsend =
    { ... }:
    {
      programs.localsend = {
        enable = true;
        openFirewall = true;
      };
    };
}
