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
  boot.kernelPackages = pkgs.linuxPackages_latest;

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
    shell = pkgs.zsh;
  };
  
  # Console
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #Hyprlandlutris
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


  # Flatpak
  #services.flatpak.enable = true;

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
  #docker
  virtualisation.docker.enable = true;

  #mysql
  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;

  #postgresql
  services.postgresql.enable = true;

  # $ nix search wget
  environment.systemPackages = with pkgs; [

#PROGRAMMING
  #Python
  (python3.withPackages (ps: with ps; [ pyqt6 dbus-python ]))
  python311Packages.pip
  python311Full
  #Rust
  rustc
  rustup
  #C/C++
  gcc
  clang
  #JavaScript
  nodejs
  #Hosts server
  hugo
  #Database
  postgresql

#HACKING
  nmap

#VISUAL
  swaylock-effects
  rofi-wayland
  obs-studio
  waybar
  swww
  dunst

#PROGRAMS
  tor-browser-bundle-bin
  telegram-desktop
  firefox-wayland
  element-desktop
  protonvpn-gui
  pavucontrol
  fragments
  qpwgraph
  scrcpy

#UTILS
  # NixOS
  pkgs.wineWowPackages.stagingFull
  pkgs.home-manager
  # Zsh
  zsh-syntax-highlighting
  zsh-autosuggestions
  # Outher
  sway-contrib.grimshot
  temurin-jre-bin-18
  wl-clipboard
  mesa-demos
  libnotify
  ntfs3g
  libGL
  file


#CONSOLE UTILS
  appimage-run
  zerotierone
  playerctl
  gamescope
  steam-run
  distrobox
  newsboat
  neofetch
  htop-vim
  cmatrix
  du-dust
  neovim
  unzip
  unrar
  wine
  cava
  foot
  mksh
  git
  mpv
  imv
  zsh
  eza
  fzf
  lf
 ];

  # Enable openVPN
  services.openvpn.servers = {
    lab_kirorisVPN  = { config = '' config /etc/nixos/starting_point_kiroris.ovpn ''; };
  };
  
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
