{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Basic system libs
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    nspr
    openssl
    curl
    expat
    mesa
    libxshmfence

    # GUI / Electron requirements
    glib
    gtk3
    pango
    cairo
    gdk-pixbuf
    atk
    at-spi2-atk
    dbus
    libdrm
    libxkbcommon
    libGL
    libgbm

    # X11 libs
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst

    cups.lib
    libxcb

    # Audio
    alsa-lib
  ];

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

    # Terminal & Shell
    kitty
    zsh

    # Desktop / Wayland
    firefox
    wofi
    waybar
    dunst
    grim
    slurp
    wl-clipboard
    brightnessctl
    playerctl
    networkmanagerapplet
    hyprpicker
    hyprshot
    satty
    waypaper
    swww

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

    # Cloud / Infra
    terraform
    terragrunt
    awscli2
    kompose
    kubectl
    kubernetes

    # Media
    vlc
    mpv
    syncplay
    pavucontrol

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
