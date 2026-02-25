{ pkgs, inputs, ... }:
{
  programs.zsh.enable = true;

  users.users.mono = {
    isNormalUser = true;
    description = "Maksym Dukhota";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "docker"
      "video"
      "audio"
      "bluetooth"
      "render"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = [ inputs.my-keys ];
  };
}
