{ ... }:
{
  flake.homeModules.home-session-vars =
    { ... }:
    {
      home.sessionVariables = {
        BROWSER = "zen-beta.desktop";
      };
    };
}
