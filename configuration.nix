# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Santiago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
#  console = {
#    font = "Lat2-Terminus16";
#    keyMap = "la-latin1";
#    useXkbConfig = true; # use xkbOptions in tty.
#  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Configure keymap in X11
  services.xserver.layout = "latam";
  services.xserver.xkbOptions = "caps:escape";

  # i3
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
	dmenu
	i3lock
	i3blocks
  ];
  services.picom.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
      enable = true;
      touchpad.tapping = false;
  };

  services.syncthing = {
    enable = true;
    user = "rh";
    configDir = "/home/rh/.config/syncthing";
    dataDir = "/home/rh/Sync";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ]; # Enable ‘sudo’ for the user.
    initialPassword = "rh";
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  };
  users.defaultUserShell = pkgs.zsh;

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpi
    bat
    discord
    dunst
    docker
    feh
    firefox
    fzf
    git
    gnucash
    kitty
    lm_sensors
    maim
    neofetch
    neovim
    networkmanagerapplet
    nodejs
    obsidian
    ripgrep
    starship
    tig
    tldr
    traceroute
    ungoogled-chromium
    unzip
    wget
    xclip
    zig
  ];

  programs.light.enable = true;
  programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
  };

  programs.tmux = {
      enable = true;
      plugins = with pkgs; [
          tmuxPlugins.continuum
          tmuxPlugins.resurrect
          tmuxPlugins.dracula
          tmuxPlugins.sessionist
      ];
  };

  fonts.fonts = with pkgs; [
      dejavu_fonts
      font-awesome
      (nerdfonts.override { fonts = [ "FiraCode" "DejaVuSansMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

