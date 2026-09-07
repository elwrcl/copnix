{ ... }:
{
  flake.homeModules.home-vscode-spellcheck =
    { config, pkgs, ... }:
    {
      xdg.configFile."cspell/.keep".text = "";
      programs.vscodium.profiles.default = {
        extensions = [ pkgs.vscode-extensions.streetsidesoftware.code-spell-checker ];

        userSettings = {
          "cSpell.enabledFileTypes" = {
            "*" = false;
            markdown = true;
            plaintext = true;
            "git-commit" = true;
          };
          "cSpell.ignorePaths" = [
            ".git/{index,*refs,*HEAD}"
            ".vscode"
            "**/.direnv/**"
            "**/.jj/**"
            "**/flake.lock"
            "**/node_modules/**"
            "**/result"
            "**/target/**"
            "package-lock.json"
          ];
          "cSpell.customDictionaries"."user-words" = {
            name = "user-words";
            path = "${config.home.homeDirectory}/.config/cspell/custom-words.txt";
            addWords = true;
            scope = "user";
          };
          "cSpell.userWords" = [
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
            "zram"
          ];
        };
      };
    };
}
