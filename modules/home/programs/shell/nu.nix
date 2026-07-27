{ ... }:

{
  programs.nushell = {
    enable = true;

    shellAliases = {
      ls = "eza --icons --group-directories-first";
      ll = "eza -lah --icons --group-directories-first";
      la = "eza -a --icons --group-directories-first";
      lt = "eza --tree --level=2 --icons";
      cat = "bat";
      df = "df -h";
      du = "du -h";
      free = "free -h";
      rm = "trash-put";
      sysinfo = "fastfetch";
      monitor = "sudo btop";
      ports = "sudo ss -tulpn";
      myip = "curl ifconfig.me";
      gs = "git status";
      ga = "git add";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };

    environmentVariables = {
      MESA_SHADER_CACHE_MAX_SIZE = "2G";
      MESA_SHADER_CACHE_DIR = "/tmp/mesa_shader_cache";
    };

    extraEnv = ''
      $env.PATH = ($env.PATH | prepend $"($env.HOME)/.local/bin")
    '';

    extraConfig = ''
      $env.config.show_banner = false
      def gc [msg: string] { git commit -m $msg }
      def rebuild [] {
          git -C ~/copland add -A
          git -C ~/copland commit -m "update"
          nh os switch
      }

      def rebuild-dry [] { nh os switch --dry }
      def rebuild-cop [] {
          nix flake update --flake ~/copland
          git -C ~/copland add -A
          git -C ~/copland commit -m $"flake update (date now | format date '%Y-%m-%d')"
          nh os switch
      }
      def extract [file: string] {
          let ext = ($file | path parse | get extension)
          match $ext {
              "gz" => { tar xzf $file },
              "bz2" => { tar xjf $file },
              "tar" => { tar xf $file },
              "zip" => { unzip $file },
              "7z" => { 7z x $file },
              "rar" => { unrar e $file },
              _ => { print $"'($file)' can't be extracted" }
          }
      }
    '';
  };
}
