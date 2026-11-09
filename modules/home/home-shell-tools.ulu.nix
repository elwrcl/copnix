{ ... }:
{
  flake.homeModules.home-shell-tools =
    { ... }:
    {
      programs.starship = {
        enable = true;
        enableNushellIntegration = false;
      };
      programs.fzf.enable = true;
      programs.zoxide = {
        enable = true;
        enableNushellIntegration = true;
        options = [ "--cmd cd" ];
      };
    };
}
