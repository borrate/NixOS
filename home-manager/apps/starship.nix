{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # "$schema" = "https://starship.rs/config-schema.json";
    settings = {
      right_format = "$time $sudo";
      format = ''
      $hostname$directory$git_branch$git_status
      $character
      '';
      directory = {
        truncation_length = 2;
        truncation_symbol = "…/";
      };
      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
        style = "bold purple";
      };
      sudo = {
        disabled = false;
        format = "[$symbol]($style)";
      };
      time = {
        disabled = false;
        format = "[$time]($style)";
      };
      env_var.USER = {
        default = "nn";
        format = "[$env_value]($style)";
        style = "201 bold"; # Ansi color 201 https://i.stack.imgur.com/KTSQa.png
      };
    };
  };
}
