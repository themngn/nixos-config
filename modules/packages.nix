{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };

  environment.systemPackages = with pkgs; [
    # Basics
    vim
    wget
    git
    htop
    btop
    tree
    killall
    fastfetch
    zip
    unzip
    bind
    ffmpeg
    sl
    bat

    # Terminal & Shell
    kitty
    zsh
    tmux

    # Desktop / Wayland
    firefox
    wofi
    waybar
    dunst
    grim
    slurp
    wl-clipboard
    hyprpicker
    hyprshot
    satty
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk

    # System Control
    brightnessctl
    playerctl
    networkmanagerapplet
    hyprlock
    hypridle
    polkit_gnome

    # Wallpaper & Screenshots
    waypaper
    swww
    swappy
    grimblast

    # File Manager & Extensions
    nemo-with-extensions
    nemo-fileroller

    # Qt & Theme
    qt5.qtwayland
    qt6.qtwayland
    adwaita-qt
    adwaita-qt6

    # Utilities
    loupe
    seahorse
    evince
    ffmpegthumbnailer
    hyprland-autoname-workspaces

    # Bluetooth
    bluez
    bluez-tools
    blueman

    # Editors & Dev tools
    neovim
    vscode
    nixfmt
    nodejs_22
    corepack
    python3
    pipx
    devbox
    nix-init
    gh

    # Cloud / Infra
    terraform
    terragrunt
    awscli2
    (azure-cli.withExtensions [ azure-cli.extensions.aks-preview ])

    # K8s
    kompose
    kubectl
    kubernetes

    # Media
    vlc
    mpv
    syncplay
    pavucontrol
    multiviewer-for-f1
    ncspot
    eartag
    picard

    # Communication
    telegram-desktop
    (discord.override { withVencord = true; })
    signal-desktop
    thunderbird
    element-desktop

    # Productivity
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    appflowy
    zoom-us

    # Files & System
    nemo
    nautilus
    yazi
    gparted
    gnome-software

    # Gaming
    gamescope
    mangohud
    protonup-qt
    bottles

    # Android / Misc
    scrcpy
    android-tools
    swayest-workstyle
    asusctl
    gnome-network-displays
    miraclecast
    glib
  ];
}
