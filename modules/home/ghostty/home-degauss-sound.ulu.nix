{ ... }:
{
  flake.homeModules.home-degauss-sound =
    { pkgs, lib, ... }:
    let
      duration = "1.5";
      variants = 8;
      generatorSource = lib.concatStringsSep "\n" (
        lib.drop 1 (lib.splitString "\n" (builtins.readFile ./degauss-sound.py))
      );

      generator = pkgs.writers.writePython3Bin "degauss-gen" {
        flakeIgnore = [
          "E501"
          "W291"
        ];
      } generatorSource;

      samples = pkgs.runCommandLocal "degauss-samples" { nativeBuildInputs = [ generator ]; } ''
        mkdir -p $out
        for i in $(seq 1 ${toString variants}); do
          degauss-gen --seed "$i" --duration ${duration} --out "$out/degauss-$i.wav"
        done
      '';

      degaussSound = pkgs.writeShellApplication {
        name = "degauss-sound";
        runtimeInputs = [ pkgs.pipewire ];
        text = ''
          n=$(( (RANDOM % ${toString variants}) + 1 ))
          exec pw-play --volume="''${DEGAUSS_VOLUME:-0.35}" "${samples}/degauss-$n.wav"
        '';
      };
    in
    {
      home.packages = [ degaussSound ];
      programs.nushell.extraConfig = lib.mkBefore ''
        if $nu.is-interactive and ($env.TERM_PROGRAM? == "ghostty") and ($env.ZELLIJ? | is-empty) {
          job spawn { ^${lib.getExe degaussSound} } | ignore
        }
      '';
    };
}
