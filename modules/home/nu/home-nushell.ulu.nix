{ ... }:
{
  flake.homeModules.home-nushell =
    { ... }:
    {
      programs.nushell = {
        enable = true;

        shellAliases = {
          ls = "eza --icons --group-directories-first";
          ll = "eza -lah --icons --group-directories-first";
          la = "eza -a --icons --group-directories-first";
          lt = "eza --tree --level=2 --icons";
          tree = "eza --tree --git-ignore --group-directories-first";

          cat = "bat";
          df = "^df -h";
          du = "^du -h";
          free = "^free -h";
          rm = "trash-put";

          sysinfo = "fastfetch";
          monitor = "sudo btop";
          ports = "sudo ss -tulpn";
          myip = "curl ifconfig.me";

          js = "jj status";
          jl = "jj log";
          jd = "jj diff";
          jc = "jj commit";
          jp = "jj git push";
          jf = "jj git fetch";

          gs = "git status";
          ga = "git add";
          gp = "git push";
          gl = "git log --oneline --graph --decorate";

          #gnu
          gfind = "^find";
          ggrep = "^grep --color=auto";
          gls = "^ls";
          gdu = "^du";
          gmkdir = "^mkdir";

          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../..";
        };

        environmentVariables = {
          MESA_SHADER_CACHE_MAX_SIZE = "2G";
          MESA_SHADER_CACHE_DIR = "/tmp/mesa_shader_cache";
          FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border";
          FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
        };

        extraEnv = ''
          $env.PATH = ($env.PATH | prepend $"($env.HOME)/.local/bin")
        '';

        extraConfig = ''
          $env.config.show_banner = false
          $env.config.history.file_format = "sqlite"
          $env.config.history.max_size = 1_000_000
          $env.config.history.isolation = false

          $env.config.edit_mode = "vi"
          $env.config.cursor_shape.vi_insert = "line"
          $env.config.cursor_shape.vi_normal = "block"

          $env.config.completions.algorithm = "substring"
          $env.config.highlight_resolved_externals = true

          def --env mc [path: path] {
            mkdir $path
            cd $path
          }

          def --env mcg [path: path] {
            mkdir $path
            cd $path
            jj git init --colocate
          }

          def rebuild [] {
            jj --repository ~/copland status | ignore
            nh os switch --accept-flake-config
          }

          def rebuild-dry [] {
            nh os switch --dry --accept-flake-config
          }

          def rebuild-up [] {
            nix flake update --flake ~/copland
            jj --repository ~/copland status | ignore
            nh os switch --accept-flake-config
          }

          def extract [file: path] {
            let name = ($file | path basename)
            match $name {
              _ if ($name | str ends-with ".tar.bz2") => { ^tar xjf $file }
              _ if ($name | str ends-with ".tar.gz")  => { ^tar xzf $file }
              _ if ($name | str ends-with ".tar.xz")  => { ^tar xJf $file }
              _ if ($name | str ends-with ".tar")     => { ^tar xf $file }
              _ if ($name | str ends-with ".bz2")     => { ^bunzip2 $file }
              _ if ($name | str ends-with ".gz")      => { ^gunzip $file }
              _ if ($name | str ends-with ".zip")     => { ^unzip $file }
              _ if ($name | str ends-with ".7z")      => { ^7z x $file }
              _ if ($name | str ends-with ".rar")     => { ^unrar e $file }
              _ => { print $"(ansi red)'($name)' açılamıyor(ansi reset)" }
            }
          }

          # `which`, with canonicalize .
          def realwhich [...applications: string, --all (-a)] {
            which --all=$all ...$applications
            | update path {|row|
                match $row.type {
                  "external" => { $row.path | path expand }
                  _ => $row.path
                }
              }
          }
        '';
      };
    };
}
