{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot.nix
    ../../modules/hardware.nix
    ../../modules/network.nix
    ../../modules/locale.nix
    ../../modules/users.nix
    ../../modules/desktop.nix
    ../../modules/packages.nix
    ../../modules/gaming.nix
    ../../modules/virtualisation.nix
    ../../modules/services.nix
  ];

  # ── Kernel ──────────────────────────────────────────────────────────────────
  # CachyOS zen4 kernel via the pinned overlay (guarantees binary cache hits)
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;

  # ── Binary caches ────────────────────────────────────────────────────────────
  nix.settings = {
    substituters = [
      "https://attic.xuyh0120.win/lantian"
      "https://cache.garnix.io"
    ];
    trusted-public-keys = [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  # ── Host identity ────────────────────────────────────────────────────────────
  networking.hostName = "nixos";

  system.stateVersion = "25.11";
}
