{ ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  # AMD GPU early KMS
  boot.initrd.kernelModules = [ "amdgpu" ];

  # AMD P-State driver for better frequency scaling
  boot.kernelParams = [
    # Fixes NVMe hangs on many AMD laptops
    "nvme_core.default_ps_max_latency_us=0"
    # Stabilizes AMD P-State (CPU power)
    "amd_pstate=active"
    # --- FIXES FOR THE GPU ERRORS ---
    # "amdgpu.dc_debug_mask=0x10" # Added underscores
    # "amdgpu.dcfeaturemask=0x2" # The missing primary fix
    "amdgpu.sg_display=0" # Critical for Ryzen 8000 stutters
    "nvme_core.default_ps_limit=0"
    "amdgpu.dcdebugmask=0x10"

    # --- FIXES FOR THE IDLE HANGS ---
    "processor.max_cstate=1" # Prevents the deep sleep "weird lag"
    "idle=nomwait"
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
