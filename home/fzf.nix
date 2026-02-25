{ pkgs, ... }:
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --exclude .git";
    defaultOptions = [
      "--multi"
      "--preview 'bat --color=always {}'"
      "--preview-window '~3'"
      "--color=dark"
      "--color=fg:-1"
      "--color=bg:-1"
      "--color=hl:#00d9ff"
      "--color=fg+:#e0e0e0"
      "--color=bg+:#2a2a2a"
      "--color=hl+:#00d9ff"
      "--color=prompt:#00d9ff"
      "--color=pointer:#ff6b6b"
      "--color=marker:#90ee90"
    ];
  };
}
