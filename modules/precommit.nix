{ inputs, pkgs, ... }:
{
  pre-commit.framework = {
    enable = true;
    pkg = inputs.pre-commit-hooks.packages.${pkgs.stdenv.hostPlatform.system}.pre-commit;
  };

  pre-commit.hooks = {
    nixfmt = {
      enable = true;
      entry = "${pkgs.nixfmt}/bin/nixfmt";
      files = "\\.nix$";
      language = "system";
      pass_filenames = true;
      description = "Format Nix files with nixfmt";
    };
  };
}
