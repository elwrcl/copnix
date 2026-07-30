{ ... }:
{
  flake.homeModules.home-shell-tools =
    { ... }:
    {
      programs.starship.enable = true;
      programs.fzf.enable = true;
      programs.zoxide.enable = true;
    };
}
