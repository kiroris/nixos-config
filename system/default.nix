{ lib, pkgs, inputs, ... }: {


# ███╗   ██╗██╗██╗  ██╗
# ████╗  ██║██║╚██╗██╔╝
# ██╔██╗ ██║██║ ╚███╔╝ 
# ██║╚██╗██║██║ ██╔██╗ 
# ██║ ╚████║██║██╔╝ ██╗
# ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝
  nix = {
    # Make nix❤️  commands consistent with the flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    #extraOptions = ''
    #  experimental-features = nix-command flakes
    #'';

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };

    optimise = {
      dates = ["weekly"];
      automatic = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };


# ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
# ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
# ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
# ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
# ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
# ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
  networking = {
    # Pick only one of the below networking options.
    # wireless.enable = true;
    networkmanager.enable = true;

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];

    # I wanna start to play HTB CTF...
    firewall.enable = true;

    # Configure network proxy if necessary.
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };


# ████████╗██╗███╗   ███╗███████╗    ██╗██╗      ██████╗  ██████╗ █████╗ ██╗     ███████╗
# ╚══██╔══╝██║████╗ ████║██╔════╝   ██╔╝██║     ██╔═══██╗██╔════╝██╔══██╗██║     ██╔════╝
#    ██║   ██║██╔████╔██║█████╗    ██╔╝ ██║     ██║   ██║██║     ███████║██║     █████╗  
#    ██║   ██║██║╚██╔╝██║██╔══╝   ██╔╝  ██║     ██║   ██║██║     ██╔══██║██║     ██╔══╝  
#    ██║   ██║██║ ╚═╝ ██║███████╗██╔╝   ███████╗╚██████╔╝╚██████╗██║  ██║███████╗███████╗
#    ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝╚═╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝
# Set your time zone.
  time.timeZone = "Europe/Minsk";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";


# ██╗   ██╗███████╗███████╗██████╗ ███████╗
# ██║   ██║██╔════╝██╔════╝██╔══██╗██╔════╝
# ██║   ██║███████╗█████╗  ██████╔╝███████╗
# ██║   ██║╚════██║██╔══╝  ██╔══██╗╚════██║
# ╚██████╔╝███████║███████╗██║  ██║███████║
#  ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝
# Don't forget to set a password with ‘passwd’.
  users.users.kirill = {
    isNormalUser = true;
    description = "kirill";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "adbusers" "wireshark" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };


# ███████╗ ██████╗ ██╗   ██╗███╗   ██╗██████╗ 
# ██╔════╝██╔═══██╗██║   ██║████╗  ██║██╔══██╗
# ███████╗██║   ██║██║   ██║██╔██╗ ██║██║  ██║
# ╚════██║██║   ██║██║   ██║██║╚██╗██║██║  ██║
# ███████║╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝
# ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝ 
  sound.enable = true;
  hardware = {
    # Enable Bluetooth.
    bluetooth.enable = true;
    # Disable pulseaudio.
    pulseaudio.enable = false;
  };


#  ██████╗ ██████╗ ███████╗███╗   ██╗ ██████╗ ██╗     
# ██╔═══██╗██╔══██╗██╔════╝████╗  ██║██╔════╝ ██║     
# ██║   ██║██████╔╝█████╗  ██╔██╗ ██║██║  ███╗██║     
# ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██║   ██║██║     
# ╚██████╔╝██║     ███████╗██║ ╚████║╚██████╔╝███████╗
#  ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };


#  ██████╗ ██████╗ ███╗   ██╗███████╗ ██████╗ ██╗     ███████╗
# ██╔════╝██╔═══██╗████╗  ██║██╔════╝██╔═══██╗██║     ██╔════╝
# ██║     ██║   ██║██╔██╗ ██║███████╗██║   ██║██║     █████╗  
# ██║     ██║   ██║██║╚██╗██║╚════██║██║   ██║██║     ██╔══╝  
# ╚██████╗╚██████╔╝██║ ╚████║███████║╚██████╔╝███████╗███████╗
#  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true; # use xkbOptions in tty.
  };


# ███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗███████╗
# ██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝██╔════╝
# ███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗  ███████╗
# ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝  ╚════██║
# ███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗███████║
# ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝╚══════╝
  services = {
    # GVFS daemon.
    gvfs.enable = false;
    
    # FWUPD daemon.
    fwupd.enable = false;

    # OpenSSH daemon.
    openssh.enable = true;

    # Flatpak daemon.
    flatpak.enable = false;   

    # CUPS deamon to print documents.
    printing.enable = false;

    # PostgreSQL daemon.
    postgresql.enable = true;
    
    # ZerotierOne daemon.
    zerotierone.enable = true;

    # W8 DIMA.
    xserver = {
      layout = "us";
      xkbVariant = "";
    };

    # Dbus daemon.
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };
    
    # PipeWire daemon.
    pipewire = {
	    enable = true;
	    alsa.enable = true;
	    alsa.support32Bit = true;
	    pulse.enable = true;
	    jack.enable = true;
    };

    # Xray daemon.
    xray = {
      enable = true;
      settingsFile = /home/kirill/.config/xray/xray.json;
    };

    # OpenVPN deamon.
    #openvpn.servers = {
    #labVPN  = { config = '' config /etc/nixos/starting_point_kiroris.ovpn ''; };
    #};
  };


# ███████╗███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██╗   ██╗
# ██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝
# ███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║    ╚████╔╝ 
# ╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██║   ██║     ╚██╔╝  
# ███████║███████╗╚██████╗╚██████╔╝██║  ██║██║   ██║      ██║   
# ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   
# tsss...be quiet
  security = {
    # Sudo enable.
    sudo.enable = true;

    # Needed for PipeWire
    rtkit.enable = true;

    # Polkit enable.
    polkit.enable = true;

    # Fix swaylock.
    # Pick one of the below fix swaylock options.
      # > First method has not been tested.
    #pam.services.swaylock = { };
      # > I use the second method.
    pam.services.swaylock.text = ''
      # PAM configuration file for the swaylock screen locker. By default, it includes
      # the 'login' configuration file (see /etc/pam.d/login)
      auth include login
    '';
  };


# ██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗███████╗
# ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝██╔════╝
# ██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  ███████╗
# ██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  ╚════██║
# ██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗███████║
# ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝
# 
  environment.defaultPackages = [ ];
  environment.systemPackages = with pkgs; [
    # system
    linuxPackages_latest.cpupower
  ];


# ██████╗ ██████╗  ██████╗  ██████╗ ██████╗  █████╗ ███╗   ███╗███████╗
# ██╔══██╗██╔══██╗██╔═══██╗██╔════╝ ██╔══██╗██╔══██╗████╗ ████║██╔════╝
# ██████╔╝██████╔╝██║   ██║██║  ███╗██████╔╝███████║██╔████╔██║███████╗
# ██╔═══╝ ██╔══██╗██║   ██║██║   ██║██╔══██╗██╔══██║██║╚██╔╝██║╚════██║
# ██║     ██║  ██║╚██████╔╝╚██████╔╝██║  ██║██║  ██║██║ ╚═╝ ██║███████║
# ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝
  programs = {
    # MTR enable.
    mtr.enable = true;

    # ADB enable.
    adb.enable = false;
    
    # Light enable.
    light.enable = true;

    # Dconf enable.
    dconf.enable = true;

    # Steam enable.
    steam.enable = true;

    # WireShark enable.
    wireshark.enable = true;

    # KDEconnect enable.
    kdeconnect.enable = false;
  };


# ██╗  ██╗██████╗  ██████╗       ██████╗  ██████╗ ██████╗ ████████╗ █████╗ ██╗     
# ╚██╗██╔╝██╔══██╗██╔════╝       ██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗██║     
#  ╚███╔╝ ██║  ██║██║  ███╗█████╗██████╔╝██║   ██║██████╔╝   ██║   ███████║██║     
#  ██╔██╗ ██║  ██║██║   ██║╚════╝██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══██║██║     
# ██╔╝ ██╗██████╔╝╚██████╔╝      ██║     ╚██████╔╝██║  ██║   ██║   ██║  ██║███████╗
# ╚═╝  ╚═╝╚═════╝  ╚═════╝       ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝
# xdg-portal needed for screen sharhing, file choosing, etc.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    # gtk portal needed to make gtk apps happy
    gtkUsePortal = true;
  };


# ██╗   ██╗██╗██████╗ ████████╗██╗   ██╗ █████╗ ██╗     ██╗███████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
# ██║   ██║██║██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██║     ██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
# ██║   ██║██║██████╔╝   ██║   ██║   ██║███████║██║     ██║███████╗███████║   ██║   ██║██║   ██║██╔██╗ ██║
# ╚██╗ ██╔╝██║██╔══██╗   ██║   ██║   ██║██╔══██║██║     ██║╚════██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
#  ╚████╔╝ ██║██║  ██║   ██║   ╚██████╔╝██║  ██║███████╗██║███████║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
#   ╚═══╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
# Configuring Containers
  virtualisation = {
    # Docker 
    docker = {
      enable = false;
      storageDriver = "btrfs";
      rootless = {
        setSocketVariable = true;
        # Sets the DOCKER_HOST variable to the rootless Docker instance for normal users by default. 
      };
    };
    # Podman
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    # Arion
    #arion = {
    #backend = "docker";
    #backend = "podman";
    #projects = {
    #"db".settings.services."db".service = {
    #  image = "";
    #  restart = "unless-stopped";
    #  environment = { POSTGRESS_PASSWORD = "password"; };
    #
    #};
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
