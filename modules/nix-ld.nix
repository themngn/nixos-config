{ pkgs, ... }:
{
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
}
