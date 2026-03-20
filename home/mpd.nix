{ pkgs, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/mono/Music";
    network.listenAddress = "127.0.0.1";
    extraConfig = ''
      auto_update "yes"
      auto_update_depth "4"
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };

  # MPD client
  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "/home/mono/Music";
  };

  # Modern Rust MPD client & CLI tool
  home.packages = with pkgs; [
    rmpc
    mpc
  ];

  # Basic rmpc configuration
  xdg.configFile."rmpc/config.ron".text = ''
    #![enable(implicit_some)]
    (
        address: "127.0.0.1:6600",
    )
  '';

  # MPRIS integration to control MPD via playerctl
  services.mpdris2.enable = true;
}
