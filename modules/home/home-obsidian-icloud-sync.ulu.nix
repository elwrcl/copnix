{ ... }:
{
  flake.homeModules.home-obsidian-icloud-sync =
    { config, pkgs, ... }:
    let
      vault = "${config.home.homeDirectory}/${config.programs.obsidian.vaults.notes.target}";
      remote = "icloud:Obsidian/elars";
      filters = pkgs.writeText "obsidian-icloud-filters.txt" ''
        - .obsidian/**
        - .trash/**
        - .DS_Store
      '';

      sync = pkgs.writeShellScript "obsidian-icloud-sync" ''
        workdir="${config.xdg.stateHome}/obsidian-icloud-sync"
        ${pkgs.coreutils}/bin/mkdir -p "$workdir"

        resync=()
        shopt -s nullglob
        listings=("$workdir"/*.lst)
        if [ ''${#listings[@]} -eq 0 ]; then
          resync=(--resync)
        fi

        if ! ${pkgs.diffutils}/bin/cmp -s ${filters} "$workdir/filters.txt"; then
          ${pkgs.coreutils}/bin/install -m644 ${filters} "$workdir/filters.txt"
          resync=(--resync)
        fi

        exec ${pkgs.rclone}/bin/rclone bisync "${vault}" "${remote}" \
          --filters-file "$workdir/filters.txt" \
          --workdir "$workdir" \
          --resilient --recover --max-lock 2m \
          --conflict-resolve newer \
          "''${resync[@]}"
      '';
    in
    {
      systemd.user.services.obsidian-icloud-sync = {
        Unit = {
          Description = "Obsidian vault <-> iCloud (rclone bisync)";
          After = [ "network-online.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${sync}";
        };
      };

      systemd.user.timers.obsidian-icloud-sync = {
        Unit.Description = "Periodic Obsidian iCloud sync";
        Timer = {
          OnStartupSec = "1min";
          OnUnitInactiveSec = "3min";
        };
        Install.WantedBy = [ "timers.target" ];
      };
    };
}
