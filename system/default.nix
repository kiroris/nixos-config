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



# ██████╗  ██████╗  ██████╗ ████████╗
# ██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝
# ██████╔╝██║   ██║██║   ██║   ██║   
# ██╔══██╗██║   ██║██║   ██║   ██║   
# ██████╔╝╚██████╔╝╚██████╔╝   ██║   
# ╚═════╝  ╚═════╝  ╚═════╝    ╚═╝  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
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
  # Disable pulseaudio.
  hardware.pulseaudio.enable = false;
  #security.rtkit.enable = true;


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
    # First method has not been tested.
    #pam.services.swaylock = { };
    # I use the second method.
    pam.services.swaylock.text = ''
      # PAM configuration file for the swaylock screen locker. By default, it includes
      # the 'login' configuration file (see /etc/pam.d/login)
      auth include login
    '';
  };


# ██████╗ ██████╗  ██████╗  ██████╗ ██████╗  █████╗ ███╗   ███╗███████╗
# ██╔══██╗██╔══██╗██╔═══██╗██╔════╝ ██╔══██╗██╔══██╗████╗ ████║██╔════╝
# ██████╔╝██████╔╝██║   ██║██║  ███╗██████╔╝███████║██╔████╔██║███████╗
# ██╔═══╝ ██╔══██╗██║   ██║██║   ██║██╔══██╗██╔══██║██║╚██╔╝██║╚════██║
# ██║     ██║  ██║╚██████╔╝╚██████╔╝██║  ██║██║  ██║██║ ╚═╝ ██║███████║
# ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝
  programs = {

    mtr.enable = true;

    light.enable = true;

    # dconf enable.
    dconf.enable = true;
    
    # KDEconnect enable.
    kdeconnect.enable = false;

    # ADB enable.
    adb.enable = false;
    
    # 
    wireshark.enable = true;
  };




















}
