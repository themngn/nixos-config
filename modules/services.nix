{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --remember-user-session --time --cmd start-hyprland";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  security.pam.services.greetd.enableGnomeKeyring = true;

  services.asusd.enable = true;
  services.flatpak.enable = true;
  services.upower.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.udisks2.enable = true;
  services.tumbler.enable = true; # Thumbnail support for images
  services.envfs.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
