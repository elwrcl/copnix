{ ... }:
{
  flake.nixosModules.service-ollama =
    { ... }:
    {
      services.ollama.enable = true;
    };
}
