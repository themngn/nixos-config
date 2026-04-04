{ pkgs, ... }:
{
  # Make nixfmt available system-wide for formatting Nix files
  environment.systemPackages = with pkgs; [
    nixfmt
  ];
}
