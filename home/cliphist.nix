{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cliphist
    wl-clipboard
  ];

  services.cliphist = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
  };
}
