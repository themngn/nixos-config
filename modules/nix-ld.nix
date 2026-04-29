{ pkgs, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Basic system libs
    stdenv.cc.cc
    stdenv.cc.cc.lib
    zlib
    glib
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
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    libxrender
    libxtst

    cups.lib
    libxcb

    # Audio
    alsa-lib
  ];
}
