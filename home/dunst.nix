{ ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#00d9ff";
        separator_color = "#3a3a3a";
        font = "JetBrains Mono 10";
        format = "<b>%s</b>\n%b";
        alignment = "center";
        vertical_alignment = "center";
        padding = 16;
        horizontal_padding = 16;
        text_icon_padding = 10;
        idle_threshold = 120;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action";
        mouse_right_click = "close_all";
        corner_radius = 5;
        progress_bar_height = 6;
        progress_bar_frame_width = 1;
        enable_posix_str_time_format = true;
      };

      urgency_low = {
        background = "#1e1e1e";
        foreground = "#a0a0a0";
        timeout = 10;
      };

      urgency_normal = {
        background = "#2a2a2a";
        foreground = "#e0e0e0";
        timeout = 10;
      };

      urgency_critical = {
        background = "#1e1e1e";
        foreground = "#ff6b6b";
        frame_color = "#ff6b6b";
        timeout = 0;
      };
    };
  };
}
