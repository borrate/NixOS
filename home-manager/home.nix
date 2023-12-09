{ config, pkgs, ... }:

{
  imports = [
    ./apps/starship.nix
    ./apps/wezterm.nix
    ./apps/zsh.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rh";
  home.homeDirectory = "/home/rh";
  xdg.cacheHome = "/home/rh/.config/cache";
  xdg.dataHome = "/home/rh/.config/local/share";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.dunst
    pkgs.docker
    pkgs.feh
    pkgs.firefox
    pkgs.gnucash
    pkgs.lazygit
    pkgs.maim
    pkgs.neofetch
    pkgs.htop
    pkgs.lua
    pkgs.networkmanagerapplet
    pkgs.nil
    pkgs.ungoogled-chromium
    pkgs.rofi
    pkgs.tmux # no eliminar, lo uso para ssh
    pkgs.z-lua

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/i3/config".source = dotfiles/i3config;
    ".config/dunst/dunstrc".source = dotfiles/dunstrc;
    ".config/nvim/init.lua".source = dotfiles/nvim.lua;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/rh/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    XDG_CONFIG_HOME="/home/rh/.config";
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=60";
  };

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
