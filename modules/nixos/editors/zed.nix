{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      zed-editor = prev.zed-editor.overrideAttrs (old: {
        env = (old.env or { }) // {
          RUSTFLAGS = ((old.env or { }).RUSTFLAGS or "") + " --cfg gles";
        };
        buildInputs = (old.buildInputs or [ ]) ++ [ prev.libGL ];
      });
    })
  ];
}
