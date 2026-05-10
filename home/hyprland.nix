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

  hyprland-pkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

  # Use hyprsplit package from its flake
  hyprsplit = inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplit;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland-pkg;
    plugins = [
      hyprsplit
    ];
    systemd.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "nemo";
      "$menu" = "vicinae toggle";

      # NOTE: Monitor layout is machine-specific — adjust for your setup
      monitor = [
        "eDP-1, 1920x1200@60, 640x1440, 1"
        "DP-1, 2560x1440@120, 2560x0, 1"
        "DP-2, 2560x1440@60, 0x0, 1"
      ];

      cursor = {
        no_hardware_cursors = true;
        enable_hyprcursor = false;
        use_cpu_buffer = true;
      };

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "waybar"
        "awww-daemon"
        "vicinae server"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "blueman-applet"
        "nm-applet"
        "hyprctl setcursor Bibata-Modern-Classic 24"
        "hyprctl keyword cursor:no_hardware_cursors false"
        "hyprctl keyword cursor:use_cpu_buffer true"
        "workstyle &> /tmp/workstyle.log"
        "sleep 1 && swww img $(find /home/mono/Pictures/Wallpapers -type f | shuf -n1)"
        "hyprland-autoname-workspaces"
        "cliphist wl-paste-listen"
      ];

      general = {
        gaps_in = 1;
        gaps_out = 1;
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      dwindle = {
        # pseudotile = true;
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
        hyprsplit = {
          num_workspaces = 5;
          persistent_workspaces = true;
        };
      };

      animations.enabled = false;

      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "MOZ_ENABLE_WAYLAND,1"
        "GDK_BACKEND,wayland,x11"
      ];

      bind = [
        "$mainMod, Q, exec, $terminal" # Terminal
        "$mainMod, C, killactive" # Kill active window
        "$mainMod SHIFT, M, exit" # Exit Hyprland
        "$mainMod, E, exec, $fileManager" # File manager
        "$mainMod, K, exec, hyprctl reload" # Reload Hyprland config
        "$mainMod, V, togglefloating" # Toggle floating window
        "$mainMod SHIFT, V, exec, cliphist menu wl-copy" # Cliphist menu
        "$mainMod CTRL, V, exec, cliphist delete-query" # Cliphist delete
        "$mainMod, W, exec, $menu" # Application menu
        "$mainMod, B, exec, firefox" # Firefox
        "$mainMod, P, pseudo," # Pseudo layout
        "$mainMod, L, exec, hyprlock" # Lock screen
        # "$mainMod, J, togglesplit" # Toggle split layout
        "$mainMod SHIFT, P, exec, pkill waybar && waybar & " # Restart waybar
        "$mainMod, A, togglespecialworkspace, M1" # Toggle special workspace M1
        "$mainMod, S, togglespecialworkspace, M2" # Toggle special workspace M2
        "$mainMod, D, togglespecialworkspace, M3" # Toggle special workspace M3
        "$mainMod SHIFT, A, movetoworkspace, special:M1" # Move window to M1
        "$mainMod SHIFT, S, movetoworkspace, special:M2" # Move window to M2
        "$mainMod SHIFT, D, movetoworkspace, special:M3" # Move window to M3
        "$mainMod, left, movefocus, l" # Focus left window
        "$mainMod, right, movefocus, r" # Focus right window
        "$mainMod, up, movefocus, u" # Focus up window
        "$mainMod, down, movefocus, d" # Focus down window
        "$mainMod, F, fullscreen, 0" # Fullscreen
        "$mainMod SHIFT, L, exec, scrcpy --render-driver=opengl -m 1080 --video-encoder='c2.android.avc.encoder'" # Mirror Android device

        # Screenshot shortcuts
        # None = region || Shift = Window || Ctrl - Output
        # +Alt = satty
        # +$mainMod = active (not for region)
        # Print: Region screenshot
        ", PRINT, exec, hyprpicker -r -z & hyprpicker_pid=$!; sleep 0.1; f=$(hyprshot -m region -o /home/mono/Pictures/Screenshots); wl-copy < \"$f\"; kill $hyprpicker_pid"
        # Alt + Print: Region screenshot with satty
        "ALT, PRINT, exec, hyprpicker -r -z & hyprpicker_pid=$!; sleep 0.1; f=$(hyprshot -m region -o /home/mono/Pictures/Screenshots); satty --filename \"$f\" --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png; wl-copy < \"$f\"; kill $hyprpicker_pid"
        # Shift + Print: Window screenshot
        "SHIFT, PRINT, exec, hyprpicker -r -z & hyprpicker_pid=$!; sleep 0.1; f=$(hyprshot -m window -o /home/mono/Pictures/Screenshots); wl-copy < \"$f\"; kill $hyprpicker_pid"
        # Shift + Alt + Print: Window screenshot with satty
        "SHIFT ALT, PRINT, exec, hyprpicker -r -z & hyprpicker_pid=$!; sleep 0.1; f=$(hyprshot -m window -o /home/mono/Pictures/Screenshots); satty --filename \"$f\" --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png; wl-copy < \"$f\"; kill $hyprpicker_pid"
        # Super + Shift + Print: Active window screenshot
        "SUPER SHIFT, PRINT, exec, hyprpicker -r -z & hyprpicker_pid=$!; sleep 0.1; f=$(hyprshot -m active -o /home/mono/Pictures/Screenshots); wl-copy < \"$f\"; kill $hyprpicker_pid"
        # Super + Shift + Alt + Print: Active window screenshot with satty
        "SUPER SHIFT ALT, PRINT, exec, hyprpicker -r -z & hyprpicker_pid=$!; sleep 0.1; f=$(hyprshot -m active -o /home/mono/Pictures/Screenshots); satty --filename \"$f\" --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png; wl-copy < \"$f\"; kill $hyprpicker_pid"
        # Ctrl + Print: Output screenshot
        "CTRL, PRINT, exec, hyprpicker -r -z & hyprpicker_pid=$!; sleep 0.1; f=$(hyprshot -m output -o /home/mono/Pictures/Screenshots); wl-copy < \"$f\"; kill $hyprpicker_pid"
        # Ctrl + Alt + Print: Output screenshot with satty
        "CTRL ALT, PRINT, exec, hyprpicker -r -z & hyprpicker_pid=$!; sleep 0.1; f=$(hyprshot -m output -o /home/mono/Pictures/Screenshots); satty --filename \"$f\" --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png; wl-copy < \"$f\"; kill $hyprpicker_pid"
        # Super + Ctrl + Print: Active output screenshot
        "SUPER CTRL, PRINT, exec, hyprpicker -r -z & hyprpicker_pid=$!; sleep 0.1; f=$(hyprshot -m active -o /home/mono/Pictures/Screenshots); wl-copy < \"$f\"; kill $hyprpicker_pid"
        # Super + Ctrl + Alt + Print: Active output screenshot with satty
        "SUPER CTRL ALT, PRINT, exec, hyprpicker -r -z & hyprpicker_pid=$!; sleep 0.1; f=$(hyprshot -m active -o /home/mono/Pictures/Screenshots); satty --filename \"$f\" --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png; wl-copy < \"$f\"; kill $hyprpicker_pid"

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
            "$mainMod, ${key}, split:workspace, ${toString ws}"
            "$mainMod SHIFT, ${key}, split:movetoworkspacesilent, ${toString ws}"
            "$mainMod, ${kpKey}, split:workspace, ${toString ws}"
            "$mainMod SHIFT, ${kpKey}, split:movetoworkspacesilent, ${toString ws}"
          ]
        ) 10
      ));

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2.5%+"
        ",XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%-"
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

        "match:class ^thunderbird$, match:title ^.*Reminders?.*$, float on"

        "match:class ^\.scrcpy-wrapped$, match:title ^motorola edge 30 neo$, float on"
        "match:class ^\.scrcpy-wrapped$, match:title ^motorola edge 30 neo$, pin on"
        "match:class ^\.scrcpy-wrapped$, match:title ^motorola edge 30 neo$, size (monitor_h*0.43) (monitor_h*0.95)"
        "match:class ^\.scrcpy-wrapped$, match:title ^motorola edge 30 neo$, move (monitor_w-window_w-20) (monitor_h/2-window_h/2)"
      ];
    };
  };
}
