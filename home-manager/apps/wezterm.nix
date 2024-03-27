{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local act = wezterm.action
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config.color_scheme = 'Tokyo Night (Gogh)'
      config.tab_bar_at_bottom = true
      config.window_background_opacity = 0.9
      -- timeout_milliseconds defaults to 1000 and can be omitted
      config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
      config.keys = {
        {
          key = '"',
          mods = 'LEADER|SHIFT',
          action = act.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
          key = '%',
          mods = 'LEADER|SHIFT',
          action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
          key = 'n',
          mods = 'LEADER',
          action = act.ActivateTabRelative(1),
        },
        {
          key = 'p',
          mods = 'LEADER',
          action = act.ActivateTabRelative(-1),
        },
        {
          key = 'c',
          mods = 'LEADER',
          action = act.SpawnTab 'CurrentPaneDomain',
        },
        {
          key = 'h',
          mods = 'LEADER',
          action = act.ActivatePaneDirection 'Left',
        },
        {
          key = 'l',
          mods = 'LEADER',
          action = act.ActivatePaneDirection 'Right',
        },
        {
          key = 'k',
          mods = 'LEADER',
          action = act.ActivatePaneDirection 'Up',
        },
        {
          key = 'j',
          mods = 'LEADER',
          action = act.ActivatePaneDirection 'Down',
        },
        -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
        {
          key = 'a',
          mods = 'LEADER|CTRL',
          action = act.SendKey { key = 'a', mods = 'CTRL' },
        },
        {
          key = ',',
          mods = 'LEADER',
          action = act.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, pane, line)
              -- line will be `nil` if they hit escape without entering anything
              -- An empty string if they just hit enter
              -- Or the actual line of text they wrote
              if line then
                window:active_tab():set_title(line)
              end
            end),
          },
        },
      }

      for i = 1, 8 do
        table.insert(config.keys, {
          key = tostring(i),
          mods = 'LEADER',
          action = act.ActivateTab(i - 1),
        })
      end

      return config
    '';
  };
}
