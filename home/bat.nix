{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "Monokai Extended";
      style = "full";
      pager = "less -R";
      map-syntax = [
        "*.dockerfile:Dockerfile"
        "build,*.mk:Makefile"
      ];
    };
  };
}
