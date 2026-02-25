{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = false;
      };

      background = {
        monitor = "";
        path = "/home/mono/Pictures/Wallpapers/Abstract/wallhaven-ly353y.jpg";
        brightness = 0.5;
      };

      input-field = {
        monitor = "";
        size = "250, 60";
        outline_thickness = 2;
        dots_center = true;
        dots_spacing = 0.2;
        dots_rounding = -1;
        outer_color = "rgb(151515)";
        inner_color = "rgb(222222)";
        font_color = "rgb(255, 255, 255)";
        font_family = "JetBrains Mono";
        fail_text = "<i>$ATTEMPTS</i>";
        placeholder_text = "<i>Password...</i>";
        hide_input = false;
        rounding = 10;
        check_color = "rgb(204, 204, 0)";
        fail_color = "rgb(204, 34, 34)";
        fail_transition = 300;
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1;
        invert_numlock = false;
        swap_font_color = false;
      };

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span>$(date +'%H:%M:%S')</span>\"";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 64;
          font_family = "JetBrains Mono";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:18000] echo \"<span>$(date +'%A, %B %d')</span>\"";
          color = "rgba(171, 171, 171, 1.0)";
          font_size = 24;
          font_family = "JetBrains Mono";
          position = "0, 150";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
