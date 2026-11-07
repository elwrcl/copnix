{ ... }:
{
  flake.homeModules.home-zed-spellcheck =
    { lib, ... }:
    let
      words = [
        "agenix"
        "bcachefs"
        "bpf"
        "clangd"
        "clvk"
        "copland"
        "crocus"
        "dendritic"
        "difftastic"
        "direnv"
        "dxvk"
        "easyeffects"
        "elars"
        "ghostty"
        "hasvk"
        "helix"
        "hyperx"
        "hyprland"
        "jujutsu"
        "kdeconnect"
        "kemuri"
        "kvantum"
        "lazyjj"
        "legcord"
        "mergiraf"
        "mesa"
        "niri"
        "nixd"
        "nixfmt"
        "nixos"
        "nixpkgs"
        "noctalia"
        "nushell"
        "pavucontrol"
        "playerctl"
        "radicle"
        "rusticl"
        "sched"
        "scrcpy"
        "soryu"
        "vscodium"
        "vsix"
        "vulkan"
        "wayland"
        "zellij"
        "zeditor"
        "zram"
      ];

      codeLanguages = [
        "C"
        "C++"
        "JSON"
        "JSONC"
        "Rust"
        "Shell Script"
        "TOML"
        "YAML"
      ];
      explicitServerLanguages = [
        "Nix"
        "Python"
      ];
    in
    {

      xdg.configFile."codebook/codebook.toml".text = ''
        words = [${lib.concatMapStringsSep ", " (word: ''"${word}"'') words}]
        ignore_paths = ["**/.direnv/**", "**/.jj/**", "**/flake.lock", "**/node_modules/**", "**/result", "**/target/**"]
      '';

      programs.zed-editor = {
        extensions = [ "codebook" ];
        userSettings.languages =
          lib.genAttrs codeLanguages (_: {
            language_servers = [
              "..."
              "!codebook"
            ];
          })
          // lib.genAttrs explicitServerLanguages (_: {
            language_servers = [ "!codebook" ];
          });
      };
    };
}
