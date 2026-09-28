{ config, ... }:
{
  flake.homeModules.home-agents = {
    imports = [
      config.flake.homeModules.home-agents-claude
    ];
  };
}
