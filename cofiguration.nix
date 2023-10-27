# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.kernelPackages = pkgs.linux_xanmod_latest;

  networking.hostName = "kiroris"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Minsk";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kirill = {
    isNormalUser = true;
    description = "kirill";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  
  # Console
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #Hyprland
  programs.hyprland.enable = true;

  #xdg-desktop-portal-hyprland
  xdg.portal = {
  enable = true;
  extraPortals = with pkgs; [
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  ];
  gtkUsePortal = true;
  };

  #Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	jack.enable = true;
  };

  #steam
  programs.steam.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;   
  
  #nix
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    optimise = {
      dates = ["weekly"];
      automatic = true;
    };
    gc = {
      dates = "weekly";
      automatic = true;
    };
  };


  #Fonts
  fonts = {
    packages = with pkgs; [
      font-awesome
      dejavu_fonts
      fira-code
      fira-code-symbols
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono"]; })
    ];
  };

  #mesa 
  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
  };

  #Shell
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.kirill.shell = pkgs.zsh;

  #swaylock
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';

  # ADB  
  programs.adb.enable = true;
 
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
  ];

  #podman
  virtualisation.podman.enable = true;

  #mysql
  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;

  #postgresql
  services.postgresql.enable = true;

  # $ nix search wget
  environment.systemPackages = with pkgs; [
  neovim
  wl-clipboard
  firefox-wayland
  waybar
  rofi-wayland
  swaylock-effects
  pkgs.wineWowPackages.stagingFull
  foot
  git
  libGL
  (python3.withPackages (ps: with ps; [ pyqt6 dbus-python ]))
  python311Full
  clang
  gcc
  neofetch
  telegram-desktop
  pkgs.home-manager
  swww
  gamescope
  wine
  dunst
  pavucontrol
  #easyeffects
  mesa-demos
  zsh
  eza
  sway-contrib.grimshot
  cava
  playerctl
  zsh-syntax-highlighting
  zsh-autosuggestions
  fzf
  docker
  lf
  scrcpy
  htop-vim
  python311Packages.pip
  element-desktop
  ntfs3g
  obs-studio
  tor-browser-bundle-bin
  unzip
  distrobox
  fragments
  bottles
  zerotierone
  appimage-run
  temurin-jre-bin-18
  cmatrix
  unrar
  rustc
  rustup
  podman
  nodejs
  postgresql
  tmux
  mpv
  imv
  hugo
  piper
 ];

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
   networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
