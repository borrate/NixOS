{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- Pull in the wezterm API
      local wezterm = require 'wezterm'

      -- This table will hold the configuration.
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      -- This is where you actually apply your config choices

      -- For example, changing the color scheme:
      config.color_scheme = 'Tokyo Night (Gohg)'
      config.tab_bar_at_bottom = true
      config.window_background_opacity = 0.9
      -- timeout_milliseconds defaults to 1000 and can be omitted
      config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
      config.keys = {
        {
          key = '|',
          mods = 'LEADER|SHIFT',
          action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
          key = '%',
          mods = 'LEADER|SHIFT',
          action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
          key = 'n',
          mods = 'LEADER',
          action = wezterm.action.ActivateTabRelative(1),
        },
        {
          key = 'p',
          mods = 'LEADER',
          action = wezterm.action.ActivateTabRelative(-1),
        },
        {
          key = 'c',
          mods = 'LEADER',
          action = wezterm.action.SpawnTab 'CurrentPaneDomain',
        },
        {
          key = 'h',
          mods = 'LEADER',
          action = wezterm.action.ActivatePaneDirection 'Left',
        },
        {
          key = 'l',
          mods = 'LEADER',
          action = wezterm.action.ActivatePaneDirection 'Right',
        },
        {
          key = 'k',
          mods = 'LEADER',
          action = wezterm.action.ActivatePaneDirection 'Up',
        },
        {
          key = 'j',
          mods = 'LEADER',
          action = wezterm.action.ActivatePaneDirection 'Down',
        },
        -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
        {
          key = 'a',
          mods = 'LEADER|CTRL',
          action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
        },
      }

      for i = 1, 8 do
        table.insert(config.keys, {
          key = tostring(i),
          mods = 'LEADER',
          action = wezterm.action.ActivateTab(i - 1),
        })
      end

      return config
    '';
  };
}
