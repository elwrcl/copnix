{ ... }:
{
  flake.homeModules.home-jujutsu-signing =
    { ... }:
    {
      # Same GPG key as common-git. Commits are signed when pushed rather than
      # on every working-copy rewrite, so gpg isn't called on each snapshot.
      programs.jujutsu.settings = {
        signing = {
          backend = "gpg";
          key = "5EA48F7312A42B84";
          behavior = "drop";
        };
        git.sign-on-push = true;
      };
    };
}
