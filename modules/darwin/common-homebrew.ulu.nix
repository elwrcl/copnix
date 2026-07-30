{ ... }:
{
  flake.darwinModules.common-homebrew =
    { ... }:
    {
      homebrew = {
        enable = true;
        onActivation = {
          autoUpdate = true;
          upgrade = true;
          cleanup = "none";
        };
        brews = [ ];
        casks = [ ];
      };
    };
}
