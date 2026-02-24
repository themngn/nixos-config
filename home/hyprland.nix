{ pkgs, inputs, ... }:
let
  # Numpad key names mapped to workspace numbers 1-10
  kpKeys = [
    "KP_End"
    "KP_Down"
    "KP_Next"
    "KP_Left"
    "KP_Begin"
    "KP_Right"
    "KP_Home"
    "KP_Up"
    "KP_Prior"
    "KP_Insert"
  ];
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.plugin_name.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun --allow-images -w 20";

      # NOTE: Monitor layout is machine-specific — adjust for your setup
      monitor = [
        "eDP-1, 1920x1200@60, 0x1440, 1"
        "HDMI-A-1, 2560x1440@144, 0x0, 1"
      ];

      cursor = {
        no_hardware_cursors = true;
        enable_hyprcursor = false;
        use_cpu_buffer = true;
      };

      exec-once = [
        "waybar"
        "hyprpm reload -n"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "blueman-applet"
        "nm-applet"
        "hyprctl setcursor Bibata-Modern-Classic 24"
        "hyprctl keyword cursor:no_hardware_cursors false"
        "hyprctl keyword cursor:use_cpu_buffer true"
        "workstyle &> /tmp/workstyle.log"
        "swww-daemon"
        "bash -c 'sleep 1 && swww img $(find /home/mono/Pictures/Wallpapers -type f | shuf -n1)'"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow.enabled = false;
        blur.enabled = false;
      };

      input = {
        kb_layout = "us, ua";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = true;
        touchpad.scroll_factor = 1.0;
      };

      gesture = [
        "3, horizontal, workspace"
      ];

      device = {
        name = "e-signal-hator-pulsar";
        sensitivity = -0.75;
      };

      plugin = {
        split-monitor-workspaces = {
          count = 10;
          keep_focused = 0;
          enable_notifications = 1;
          enable_persistent_workspaces = 1;
        };
      };

      animations.enabled = false;

      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
      ];

      bind =
        [
          "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive"
          "$mainMod SHIFT, M, exit"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, K, exec, hyprctl reload"
          "$mainMod, V, togglefloating"
          "$mainMod, W, exec, $menu"
          "$mainMod, B, exec, firefox"
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit"
          "$mainMod SHIFT, P, exec, pkill waybar && waybar & "
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, F, fullscreen, 0"
          "$mainMod SHIFT, L, exec, scrcpy --render-driver=opengl -m 1080 --video-encoder='c2.android.avc.encoder'"
          ", Print, exec, bash -c 'f=$(hyprshot -zm region -o /home/mono/Pictures/Screenshots); wl-copy < \"$f\"'"
          "$mainMod SHIFT, PRINT, exec, bash -c 'f=$(hyprshot -m active -m output -o /home/mono/Pictures/Screenshots); wl-copy < \"$f\"'"
          "$mainMod, PRINT, exec, bash -c 'f=$(hyprshot -m output -o /home/mono/Pictures/Screenshots); wl-copy < \"$f\"'"
          "SHIFT, PRINT, exec, bash -c 'f=$(hyprshot -m active -m window -o /home/mono/Pictures/Screenshots); wl-copy < \"$f\"'"
          "CTRL, PRINT, exec, bash -c 'f=$(hyprshot -m window -o /home/mono/Pictures/Screenshots); wl-copy < \"$f\"'"
          "Control&Shift, PRINT, exec, grim -g \"$(slurp)\" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
              key = if ws == 10 then "0" else toString ws;
              kpKey = builtins.elemAt kpKeys i;
            in
            [
              "$mainMod, ${key}, split-workspace, ${toString ws}"
              "$mainMod SHIFT, ${key}, split-movetoworkspacesilent, ${toString ws}"
              "$mainMod, ${kpKey}, split-workspace, ${toString ws}"
              "$mainMod SHIFT, ${kpKey}, split-movetoworkspacesilent, ${toString ws}"
            ]
          ) 10
        ));

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      windowrule = [
        "match:title ^(Picture-in-Picture)$, float on"
        "match:title ^(Picture-in-Picture)$, pin on"
        "match:title ^(Picture-in-Picture)$, size 600 340"
        "match:title ^(Picture-in-Picture)$, move 1320 25"

        "match:class ^\.scrcpy-wrapped$, match:title ^motorola edge 30 neo$, float on"
        "match:class ^\.scrcpy-wrapped$, match:title ^motorola edge 30 neo$, pin on"
        "match:class ^\.scrcpy-wrapped$, match:title ^motorola edge 30 neo$, size (monitor_h*0.43) (monitor_h*0.95)"
        "match:class ^\.scrcpy-wrapped$, match:title ^motorola edge 30 neo$, move (monitor_w-window_w-20) (monitor_h/2-window_h/2)"
      ];
    };
  };
}
