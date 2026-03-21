{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Powerlevel10k instant prompt (must be at the very top of .zshrc)
    initContent = lib.mkBefore (
      ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      ''
      + ''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        export PATH="$HOME/.npm-global/bin:$PATH"

        mk-tf() {
            mkdir -p "$1" && touch "$1"/{main.tf,variables.tf,outputs.tf}
            echo "Terraform module '$1' created."
        }
      ''
    );

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      v = "nvim";
      goodnight = "echo 'Good night! Sleep tight!' && systemctl poweroff";
      ssh = "kitty +kitten ssh";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
    };
  };
}
