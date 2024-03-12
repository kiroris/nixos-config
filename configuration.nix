# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      #./hardware-configuration.nix
    ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  #networking.hostName = "kiroris"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  #networking.networkmanager.enable = true;

  ## Set your time zone.
  #time.timeZone = "Europe/Minsk";

  ## Select internationalisation properties.
  #i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  #services.xserver = {
  #  layout = "us";
  #  xkbVariant = "";
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  #users.users.kirill = {
  #  isNormalUser = true;
  #  description = "kirill";
  #  extraGroups = [ "networkmanager" "wheel" "adbusers"];
  #  packages = with pkgs; [];
  #  shell = pkgs.zsh;
  #};

  # Shell
  #programs.zsh = {
  ##  enable = true;
  #  enableAutosuggestions = true;
 ##  enableSyntaxHighlighting = true;
  #  syntaxHighlighting.enable = true;
  #  enableCompletion = true;
  #};  
  #users.defaultUserShell = pkgs.zsh;

  ## Console
  #console = {
  #  font = "Lat2-Terminus16";
  #  # keyMap = "us";
  #  # useXkbConfig = true; # use xkbOptions in tty.
  #};

  # Tmux
  programs.tmux = {
  enable = true;
  clock24 = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Hyprlandlutris
  programs.hyprland.enable = true;

  ## Xdg-desktop-portal-hyprland
  #xdg.portal = {
  #enable = true;
  #extraPortals = with pkgs; [
  #xdg-desktop-portal-hyprland
  #xdg-desktop-portal-gtk
  #];
  #gtkUsePortal = true;
  #};

  ## Enable sound with pipewire
  #sound.enable = true;
  #hardware.pulseaudio.enable = false;
  #security.rtkit.enable = true;
  #services.pipewire = {
	#enable = true;
	#alsa.enable = true;
	#alsa.support32Bit = true;
	#pulse.enable = true;
	#jack.enable = true;
  #};

  ## Nix
  #nix = {
  #  settings = {
  #    experimental-features = ["nix-command" "flakes"];
  #    auto-optimise-store = true;
  #  };
  #  optimise = {
  #    dates = ["weekly"];
  #    automatic = true;
  #  };
  #  gc = {
  #    dates = "weekly";
  #    automatic = true;
  #  };
  #};

  # Fonts
  #fonts = {
  #  packages = with pkgs; [
  #    font-awesome
  #    dejavu_fonts
  #    fira-code
  #    fira-code-symbols
  #    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono"]; })
  #  ];
  #};

  ## Mesa 
  #hardware = {
  #  opengl = {
  #    enable = true;
  #    driSupport32Bit = true;
  #    extraPackages = with pkgs; [
  #      rocmPackages.clr.icd
  #    ];
  #  };
  #};

  #nixpkgs.config.permittedInsecurePackages = [
  #  "openssl-1.1.1v"
  #];
  
  # Gvfs
  #services.gvfs = {
  #  enable = true;
  #};
  
  # Tor 
  services.tor.enable = true;
  services.tor.client.enable = true;
  services.tor.settings = {
      UseBridges = true;
      ClientTransportPlugin = "obfs4 exec ${pkgs.obfs4}/bin/obfs4proxy";
      Bridge = "obfs4 IP:ORPort [fingerprint]";
  };

  # Steam
  #programs.steam.enable = true;

  # Bluetooth
  #hardware.bluetooth.enable = true;   

  # Flatpak
  #services.flatpak.enable = true;

  # ADB  
  #programs.adb.enable = true; 

  # Podman
  #virtualisation = {
  #  podman = {
  #    enable = true;

  #    # Create a `docker` alias for podman, to use it as a drop-in replacement
  #    dockerCompat = true;

  #    # Required for containers under podman-compose to be able to talk to each other.
  #    defaultNetwork.settings.dns_enabled = true;
  #  };
  #};

  # Docker
  #virtualisation.docker.enable = true;

  # waydroid
  #virtualisation.waydroid.enable = true;

  # PostgreSQL
  #services.postgresql.enable = true;

  #environment.variables.EDITOR = "nvim";

  # xray
  #services.xray = {
  #  enable = true;
  #  settingsFile = /home/kirill/.config/xray/xray.json;
  #};

  #programs.wireshark.enable = true;


  # Swaylock
  #security.pam.services.swaylock.text = ''
  #  # PAM configuration file for the swaylock screen locker. By default, it includes
  #  # the 'login' configuration file (see /etc/pam.d/login)
  #  auth include login
  #'';
  
  # $ nix search wget
  environment.systemPackages = with pkgs; [

#PROGRAMMING
  # Editors
  neovim
  #vscode
  # Python
  (python3.withPackages (ps: with ps; [ pyqt6 ]))
  python311Packages.pip
  python311Full
  # Java
  temurin-jre-bin-18
  # Rust
  rustc
  cargo
  rustup
  # Go 
  go
  # C/C++
  gnumake
  clang
  gcc
  # Database
  pgadmin4-desktopmode
  #postgresql
  # Hosts
  #hugo
  # Git 
  #git

#HACKING
  #inetutils
  radare2
  iaito
  nmap
  lsof


#ZIPS
  #unzip
  #unrar
  #p7zip


#VISUAL
  swaylock-effects
  rofi-wayland
  eww-wayland
  waybar
  dunst
  swww


#PROGRAMS
  telegram-desktop
  firefox-wayland
  element-desktop
  gnome.nautilus
  #pavucontrol
  obs-studio
  winetricks
  fragments
  #qpwgraph
  bottles
  spotify
  #scrcpy
  heroic
  foot
#
  mpv
  imv


#CLI UTILS
  shadowsocks-rust
  #playerctl
  tty-clock
  swayidle
  neofetch
  #htop-vim
  cmatrix
  du-dust
  #pamixer
  #light
  #btop
  cava

#laptop
  acpi
  #duf
  eza
  #fzf
  lf
  

#UTILS
  # NixOS
  pkgs.wineWowPackages.stagingFull
  pkgs.home-manager
  #zsh-syntax-highlighting
  #zsh-autosuggestions
  # Outher
  pkgs.android-udev-rules
  sway-contrib.grimshot
  #pkgs.cifs-utils
  #wl-clipboard
  #mesa-demos
  #libnotify
  #ntfs3g
  #libGL
  #file
  wine


#OTHER
  appimage-run
  #zerotierone
  #mesa-demos
  gamescope
  #steam-run
  distrobox
  qemu_full
  mangohud
  gamemode



  ffmpeg_5-full
  ungoogled-chromium
  librewolf
  zathura
  #xdg-utils
  
  #shotcut
  #xray
  libsForQt5.kdenlive
  anytype
  fluffychat
  libsForQt5.neochat
  fractal
  nheko
  gomuks
  #olive-editor
  #piper
  gimp
  libsForQt5.kdenlive
  transmission
  #vmware-workstation
  podman-compose

  libnotify
  wayland


  gnome3.adwaita-icon-theme
  wl-clipboard
  pavucontrol
  playerctl
  xdg-utils
  qpwgraph
  pamixer
  neovim
  duf
  git

  ntfs3g
  libGL
  glib # gsettings.

  ];

  # Enable openVPN
#  services.openvpn.servers = {
#    labVPN  = { config = '' config /etc/nixos/starting_point_kiroris.ovpn ''; };
#  };
#  
  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;

  #zerotierone
  #services.zerotierone.enable = true;

  # Open ports in the firewall.
  #networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "23.05"; # Did you read the comment?

}
