{ ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # AMD GPU early KMS
  boot.initrd.kernelModules = [ "amdgpu" ];

  # AMD P-State driver for better frequency scaling
  boot.kernelParams = [
    # Fixes NVMe hangs on many AMD laptops
    "nvme_core.default_ps_max_latency_us=0"
    # Stabilizes AMD P-State (CPU power)
    "amd_pstate=active"
    # Disable LTTPR support
    "amdgpu.dcfeaturemask=0x2"
    # Disable scatter/gather display (helps with Zen 4 stability)
    "amdgpu.sg_display=0"
  ];

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
