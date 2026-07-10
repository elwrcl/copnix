{ pkgs, ... }:
{
  imports = [
    ./niri.nix
  ];

  home.packages = with pkgs; [
    (discord-canary.override { withMoonlight = true; })
  ];

  home.username = "elars";
  home.homeDirectory = "/home/elars";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    BROWSER = "zen-beta.desktop";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

      alias ls='eza --icons --group-directories-first'
      alias ll='eza -lah --icons --group-directories-first'
      alias la='eza -a --icons --group-directories-first'
      alias lt='eza --tree --level=2 --icons'

      alias cd='z'
      alias cat='bat'
      alias grep='grep --color=auto'
      alias df='df -h'
      alias du='du -h'
      alias free='free -h'

      alias cp='cp -i'
      alias mv='mv -i'
      alias rm='trash-put'

      alias sysinfo='fastfetch'
      alias monitor='sudo btop'
      alias ports='sudo ss -tulpn'
      alias myip='curl ifconfig.me'

      alias ..='cd ..'
      alias ...='cd ../..'
      alias ....='cd ../../..'
      alias ~='cd ~'
      alias -- -='cd -'

      alias gs='git status'
      alias ga='git add'
      alias gc='git commit -m'
      alias gp='git push'
      alias gl='git log --oneline --graph --decorate'

      alias rebuild='git -C ~/copland add -A && git -C ~/copland commit -m "update" && nh os switch'
      alias rebuild-dry='nh os switch --dry'
      alias rebuild-cop='nix flake update --flake ~/copland && git -C ~/copland add -A && git -C ~/copland commit -m "flake update $(date +%Y-%m-%d)" && nh os switch'

      extract() {
        if [ -f "$1" ]; then
          case "$1" in
            *.tar.bz2) tar xjf "$1" ;; *.tar.gz)  tar xzf "$1" ;;
            *.bz2)     bunzip2 "$1"  ;; *.rar)     unrar e "$1" ;;
            *.gz)      gunzip "$1"   ;; *.tar)     tar xf "$1"  ;;
            *.zip)     unzip "$1"    ;; *.7z)      7z x "$1"    ;;
            *) echo "'$1' can't be extracted" ;;
          esac
        fi
      }

      HISTSIZE=10000
      SAVEHIST=10000
      HISTFILE=~/.zsh_history
      setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY AUTO_CD
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

      export MESA_SHADER_CACHE_MAX_SIZE=2G
      export MESA_SHADER_CACHE_DIR=/tmp/mesa_shader_cache
      export PATH="$HOME/.local/bin:$PATH"

      /home/elars/.config/copetch/animated-copetch.sh
    '';
  };

  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.zoxide.enable = true;

  gtk = {
    enable = true;
    theme.name = "Graphite-Dark";
    theme.package = pkgs.graphite-gtk-theme;
    gtk4.theme.name = "Graphite-Dark";
    gtk4.theme.package = pkgs.graphite-gtk-theme;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-application-prefer-dark-theme = true;
    gtk-theme = "Graphite-Dark";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "org.kde.dolphin.desktop" ];
      "x-scheme-handler/http" = [ "zen-beta.desktop" ];
      "x-scheme-handler/https" = [ "zen-beta.desktop" ];
      "x-scheme-handler/about" = [ "zen-beta.desktop" ];
      "x-scheme-handler/unknown" = [ "zen-beta.desktop" ];
    };
  };
  services.easyeffects.enable = true;
}
