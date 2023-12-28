{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "none";
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "50x50";
        scale = 0;
        notification_limit = 0;
        transparency = 10;
        frame_color = "#eceff1";
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        indicate_hidden = "yes";
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 2;
        separator_color = "frame";
        font = "FantasqueSansMono 10";
        line_height = 0;
        markup = "full";
        format = "<span foreground='#f3f4f5'> ‏‏‎ ‎<b>%s %p</b></span>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        icon_position = "left";
      };

      urgency_low = {
        background = "#222222";
        foreground = "#888888";
        timeout = 5;
      };

      urgency_normal = {
        background = "#222222";
        foreground = "#888888";
        frame_color = "#7851a9";
        timeout = 5;
      };

      urgency_critical = {
        background = "#222222";
        foreground = "#888888";
        frame_color = "#ff0000";
        timeout = 0;
      };
    };
  };
}
