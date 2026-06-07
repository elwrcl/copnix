{ pkgs, ... }:
{
  system.primaryUser = "sohryu";
  users.users.sohryu = {
    name = "sohryu";
    home = "/Users/sohryu";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  environment.systemPackages = [ pkgs.nh ];
  environment.variables.NH_FLAKE = "/Users/sohryu/copland";
}
