{ pkgs, ... }:
{
  programs.npm = {
    enable = true;
    settings = {
      init-author-name = "mono";
      init-version = "0.0.1";
    };
  };

  home.packages = with pkgs; [
    nodejs
    nodePackages.gemini
  ];
}
