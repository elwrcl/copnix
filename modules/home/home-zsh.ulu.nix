{ ... }:
{
  flake.homeModules.home-zsh =
    { ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        initContent = ''
          alias ls='eza --icons --group-directories-first'
          alias ll='eza -lah --icons --group-directories-first'
          alias cat='bat'
          alias rm='trash-put'

          HISTSIZE=10000
          SAVEHIST=10000
          HISTFILE=~/.zsh_history
          setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY AUTO_CD
          zstyle ':completion:*' menu select
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

          export MESA_SHADER_CACHE_MAX_SIZE=2G
          export MESA_SHADER_CACHE_DIR=/tmp/mesa_shader_cache
          export PATH="$HOME/.local/bin:$PATH"
        '';
      };
    };
}
