{ ... }:
{
  commonModules.common-git =
    { pkgs, ... }:
    let
      base = ''
        [user]
        	name = elwrcl
        	email = elwerici@proton.me
        	signingkey = 5EA48F7312A42B84
        [commit]
        	gpgsign = true
        [tag]
        	gpgsign = true
      '';

      darwinExtra = ''
        [credential]
        	helper = osxkeychain
      '';

      linuxExtra = ''
        [credential]
        	helper = ${pkgs.gitFull}/bin/git-credential-libsecret
      '';

      gitconfig = pkgs.writeText "gitconfig" (
        base + (if pkgs.stdenv.isDarwin then darwinExtra else linuxExtra)
      );
    in
    {
      environment.variables.GIT_CONFIG_SYSTEM = "${gitconfig}";
    };
}
