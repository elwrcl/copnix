# AGENTS.md

On this configuration, rules exist to keep it from turning into an
unmanageable mess as it grows across multiple machines.

## Development rules

- For version control: try not to use `git` directly. Instead of
  `git add`, use `jj file track`. The repo is colocated with git
  (jj on top, `.git/` still present) so it stays compatible with
  repository.
- Never commit or push on your own (neither `jj commit`/`jj git push`
  nor `git commit`/`git push`). Leave changes tracked/staged and stop
  there — the human reviews and commits/pushes themselves.
- Always use the Dendritic Pattern: every module file ends in
  `*.ulu.nix` and is auto-discovered by `flake.nix`. There is no
  central `imports = [ ... ]` list anywhere in the repo.
- `flake.nix` itself only does discovery (`listFilesRecursive` +
  `hasSuffix ".ulu.nix"`). Never add a manual import list back into
  `flake.nix`, no matter how tempting it seems for "just this one
  file".
- Where you place a `*.ulu.nix` file in the directory tree is for
  human organization only. It has no effect on whether the file is
  loaded. Directory names should describe the topic
  (`modules/nixos/`, `hosts/`, `services/`), not the loading
  mechanism.
- Never use old-style `nix-*` commands. Always prefer the new `nix3`
  commands (`nix build` over `nix-build`, `nix flake check` over
  `nix-instantiate`, and so on).

## File arrangement

- A module file should do ONE thing. If you can't describe what a
  file does in one sentence without using "and", split it into two
  files.
- There is no fixed line-count limit — a genuinely complex, single
  concern (e.g. a from-scratch service definition) is allowed to be
  long. What's not allowed is a grab-bag file that bundles unrelated
  concerns together because it was convenient at the time (this repo
  has explicitly rejected the "one giant catch-all file" pattern).
- If you're adding to an existing file and the addition isn't the
  same concern as the rest of the file, create a new `*.ulu.nix` file
  instead of appending.

## The module pool is not an active list

- `flake.nixosModules.*`, `flake.darwinModules.*`, and
  `flake.homeModules.*` are a **registry**, not a set of things that
  are automatically active. A module existing in the pool has zero
  effect on any host until a host explicitly imports it by name.
- Host files (`hosts/<hostname>.ulu.nix`) must NEVER pull the whole
  pool in automatically. Do not write
  `builtins.attrValues config.flake.nixosModules` (or `attrNames`,
  or any other "grab everything" construct) in a host file. Every
  host lists the exact modules it wants, by name:

  ```nix
  modules = [
    config.flake.nixosModules.common
    config.flake.nixosModules.gaming
    config.flake.nixosModules.niri
  ];
  ```

- If the same group of modules is reused across multiple hosts,
  create a profile file (e.g. `gaming-profile.ulu.nix`) whose only
  job is to list other module names under one name. A profile file
  must not contain new logic of its own, only composition.

## Naming

- Custom option namespace: `elars.*` (e.g.
  `elars.hardware.graphics.driver`, `elars.desktop.compositor`).
  Don't invent a second namespace.
- Module names in the pool are prefixed by domain so the pool stays
  browsable as it grows:
  - `common-*` — shared across every host regardless of role
  - `hw-*` — hardware-specific modules (graphics, bluetooth, etc.)
  - `net-*` — networking
  - `service-*` — systemd services / daemons
  - `gaming-*` — Steam and anything gaming-related
  - `desktop-*` — window managers / compositors (niri, hyprland) and
    other desktop-session-level nixos modules
  - `home-*` — home-manager modules that are not a window manager
    (git, shell programs, dotfile-level config)
- Host file name must exactly match the hostname it defines
  (`hosts/canavar.ulu.nix` defines `networking.hostName = "canavar"`,
  not something else). Prefer adding a sanity assertion that checks
  this rather than relying on discipline alone.
- Never abbreviate platform names inconsistently. Choose "darwin"
  instead of "macos", and use it everywhere in file/module names.

## Toolchain notes

- Version control: jj, colocated with git (see Development rules).
- Formatter: nixfmt.
- User-level config: home-manager. (hjem was considered but rejected —
  home-manager stays.)

## What NOT to do

- Don't reintroduce a central `default.nix` that manually lists
  `imports = [ ./a.nix ./b.nix ]`. That's the pattern we're moving
  away from.
- Don't create a file just because "it needs to live somewhere for
  now" — if it doesn't have a clear single concern yet, it's not
  ready to be a `*.ulu.nix` file.
- Don't use `builtins.attrValues`/`attrNames` to wire a host's module
  list. Every host's module list must be explicit and readable at a
  glance.