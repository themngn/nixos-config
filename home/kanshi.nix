{
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.0;
            status = "enable";
          }
        ];
        exec = [ "hyprctl keyword plugin:split-monitor-workspaces:count 15" ];
      };

      one_monitor = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.0;
            status = "enable";
          }
          {
            criteria = "DP-2";
            scale = 1.0;
            status = "enable";
          }
        ];
        exec = [ "hyprctl keyword plugin:split-monitor-workspaces:count 10" ];
      };

      two_monitors = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.0;
            status = "enable";
          }
          {
            criteria = "DP-2";
            scale = 1.0;
            status = "enable";
          }
          {
            criteria = "HDMI-A-1";
            scale = 1.0;
            status = "enable";
          }
        ];
        exec = [ "hyprctl keyword plugin:split-monitor-workspaces:count 5" ];
      };
    };
  };
}
