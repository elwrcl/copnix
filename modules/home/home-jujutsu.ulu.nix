{ ... }:
{
  flake.homeModules.home-jujutsu =
    { pkgs, lib, ... }:
    let
      inherit (lib.meta) getExe;
    in
    {
      programs.jujutsu = {
        enable = true;

        settings = {
          user = {
            name = "elwrcl";
            email = "elwerici@proton.me";
          };

          aliases.".." = [
            "edit"
            "@-"
          ];
          aliases.",," = [
            "edit"
            "@+"
          ];

          aliases.f = [
            "git"
            "fetch"
          ];
          aliases.p = [
            "git"
            "push"
          ];

          aliases.a = [ "abandon" ];
          aliases.c = [ "commit" ];
          aliases.ci = [
            "commit"
            "--interactive"
          ];
          aliases.d = [ "diff" ];
          aliases.e = [ "edit" ];
          aliases.l = [ "log" ];
          aliases.la = [
            "log"
            "--revisions"
            "::"
          ];
          aliases.s = [ "squash" ];
          aliases.si = [
            "squash"
            "--interactive"
          ];
          aliases.u = [ "undo" ];

          # `jj fork` — renames the current `origin` remote to `upstream`, forks
          # the repository on GitHub via `gh`, and tracks the trunk bookmark.
          aliases.fork = [
            "util"
            "exec"
            "--"
            (getExe (
              pkgs.writeShellScriptBin "jj-fork" ''
                remote_names() {
                  jj git remote list | cut -d' ' -f1
                }

                if ! remote_names | grep -qx upstream; then
                  jj git remote rename origin upstream
                fi

                if ! remote_names | grep -qx origin; then
                  ${getExe pkgs.gh} repo fork --remote --remote-name origin
                fi

                jj git fetch

                trunk_remote=$(jj config get 'revset-aliases."trunk()"' | cut -d'@' -f1)
                jj bookmark track "$trunk_remote"
              ''
            ))
          ];

          revsets.log = # python
            ''
              present(@) | present(trunk()) | ancestors(remote_bookmarks().. | @.., 8)
            '';

          ui.default-command = "log";
          ui.diff-editor = ":builtin";
          ui.conflict-marker-style = "snapshot";

          templates.draft_commit_description = # python
            ''
              concat(
                coalesce(description, "\n"),
                surround(
                  "\nJJ: This commit contains the following changes:\n", "",
                  indent("JJ:     ", diff.stat(72)),
                ),
                "\nJJ: ignore-rest\n",
                diff.git(),
              )
            '';

          remotes."*" = {
            auto-track-bookmarks = "elwrcl/*";
            push-new-bookmarks = true;
          };

          templates.git_push_bookmark = ''"elwrcl/change-" ++ change_id.short()'';

          git.fetch = [
            "origin"
            "upstream"
          ];
          git.push = "origin";
        };
      };
    };
}
