{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Powerlevel10k instant prompt (must be at the very top of .zshrc)
    initContent = lib.mkBefore (''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '' + ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '');

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      LANG = "en_US.UTF-8";
      WAYLAND_DISPLAY = "wayland-0";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };

    shellAliases = {
      # Filesystem
      ll = "ls -lh";
      la = "ls -lah";
      l = "ls -lah";
      mkdir = "mkdir -pv";
      
      # Nix
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      upgrade = "sudo nixos-rebuild switch --flake /etc/nixos#nixos --upgrade";
      flake-update = "nix flake update /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      
      # Editor
      v = "nvim";
      vim = "nvim";
      
      # Git shortcuts
      g = "git";
      ga = "git add";
      gc = "git commit";
      gca = "git commit --amend";
      gd = "git diff";
      gl = "git log --oneline -10";
      gp = "git push";
      gpl = "git pull";
      gs = "git status";
      gco = "git checkout";
      gb = "git branch";
      gr = "git reset";
      
      # Utility
      cat = "bat --style=plain";
      du = "du -h";
      df = "df -h";
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      goodnight = "echo 'Good night! Sleep tight!' && systemctl poweroff";
      please = "sudo";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
    };

    historySubstringSearch.enable = true;

    envExtra = ''
      # Zsh options
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt EXTENDED_HISTORY
      setopt SHARE_HISTORY
    '';

    loginExtra = ''
      # Utility functions
      # Create directory and cd into it
      mcd() {
        mkdir -p "$1" && cd "$1"
      }
      
      # Extract archives
      extract() {
        if [[ -f $1 ]]; then
          case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) unrar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *.deb) ar x $1 ;;
            *.xz) unxz $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }
    '';
  };
}
