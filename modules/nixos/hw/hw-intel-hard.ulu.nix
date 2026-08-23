{ inputs, ... }:
{
  flake.nixosModules.hw-intel-hard =
    { ... }:
    {
      imports = [ inputs.intel-hard.nixosModules.default ];

      # No paths here on purpose: every one of them comes from the flake's
      # topology.nix. If a tree moves, that file is the only edit.
      programs.intel-hard.enable = true;
    };
}
