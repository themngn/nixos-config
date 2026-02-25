{ ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    settings = {
      # General
      confirm_os_window_close = 0;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      hide_window_decorations = "yes";
      
      # Visual
      background_opacity = "0.95";
      window_padding_width = "8";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
      
      # Cursor
      cursor_shape = "block";
      cursor_blink_interval = 0;
      
      # Performance
      sync_to_monitor = "yes";
      repaint_delay = 10;
    };
  };
}
