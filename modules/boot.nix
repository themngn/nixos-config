{ ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # AMD GPU early KMS
  boot.initrd.kernelModules = [ "amdgpu" ];

  # AMD P-State driver for better frequency scaling
  boot.kernelParams = [ "amd_pstate=active" ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "mono"
    ];
  };

  nixpkgs.config.allowUnfree = true;
}
