{ ... }:
{
  flake.nixosModules.common-git =
    { pkgs, ... }:
    let
      gitconfig = pkgs.writeText "gitconfig" ''
        [user]
        	name = elwrcl
        	email = elwerici@proton.me
        	signingkey = 5EA48F7312A42B84
        [commit]
        	gpgsign = true
        [tag]
        	gpgsign = true
        [credential]
        	helper = ${pkgs.gitFull}/bin/git-credential-libsecret
      '';
    in
    {
      environment.variables.GIT_CONFIG_SYSTEM = "${gitconfig}";
    };
}
