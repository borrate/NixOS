# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
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

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  #  console = {
  #    font = "Lat2-Terminus16";
  #    keyMap = "la-latin1";
  #    useXkbConfig = true; # use xkbOptions in tty.
  #  };


  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    initialPassword = "rh";
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  home-manager.users.rh.imports = [ ./home-manager/home.nix ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # Agrega ~/.local/bin/ al $PATH
  environment.localBinInPath = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpi
    bat
    cargo
    discord
    fzf
    git
    lm_sensors
    neovim
    nodejs
    obsidian
    ripgrep
    tig
    tldr
    traceroute
    unzip
    wget
    xclip
    zig
  ];

  # backlight control
  programs.light.enable = true;
  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
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
  services.syncthing = {
    enable = true;
    user = "rh";
    configDir = "/home/rh/.config/syncthing";
    dataDir = "/home/rh/Sync";
  };

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

  # Autologin
  services.xserver.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "rh";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    touchpad.tapping = false;
  };

  services.picom.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

