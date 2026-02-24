{ pkgs, ... }:
{
  # AMD GPU driver
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  powerManagement.cpuFreqGovernor = "performance";

  hardware.steam-hardware.enable = true;
}
