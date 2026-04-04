{ ... }:
{
  # Automatic garbage collection to free up disk space
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Automatically optimize Nix store to deduplicate store paths
  nix.optimise.automatic = true;

  # Configure XDG user directories for standardized Downloads, Documents, etc.
  xdg.userDirs.enable = true;
}
