{
  pkgs,
  lib,
  ...
}:

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

  gitconfig = pkgs.writeText "gitconfig" (base + lib.optionalString pkgs.stdenv.isDarwin darwinExtra);
in
{
  environment.variables.GIT_CONFIG_SYSTEM = "${gitconfig}";
}
