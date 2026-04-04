{ pkgs, ... }:
{
  # Make nixfmt available system-wide for formatting Nix files
  environment.systemPackages = with pkgs; [
    nixfmt
  ];

  # Note: To enable git pre-commit hooks, run:
  # git config core.hooksPath /path/to/hooks
  # Then create hooks/pre-commit with formatting logic
}
