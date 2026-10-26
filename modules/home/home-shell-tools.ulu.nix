{ ... }:
{
  flake.homeModules.home-shell-tools =
    { ... }:
    {
      programs.starship = {
        enable = true;
        # nushell has its own jj prompt (home-nushell-prompt)
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
