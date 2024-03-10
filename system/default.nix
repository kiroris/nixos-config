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

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };


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

  # Set your time zone.
  time.timeZone = "Europe/Minsk";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Console
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Mesa OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
  

# ███████╗ ██████╗ ██╗   ██╗███╗   ██╗██████╗ 
# ██╔════╝██╔═══██╗██║   ██║████╗  ██║██╔══██╗
# ███████╗██║   ██║██║   ██║██╔██╗ ██║██║  ██║
# ╚════██║██║   ██║██║   ██║██║╚██╗██║██║  ██║
# ███████║╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝
# ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝ 

  # Disable PulseAudio
  hardware.pulseaudio.enable = false;

  # Enable sound with pipewire
  security.rtkit.enable = true;
  sound.enable = true;
  # PipeWire
  services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  pulse.enable = true;
	  jack.enable = true;
  };


# ███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗███████╗
# ██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝██╔════╝
# ███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗  ███████╗
# ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝  ╚════██║
# ███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗███████║
# ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝╚══════╝
  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;
    
    # Enable the ZerotierOne daemon.
    zerotierone.enable = true;
    
    # Enable the Dbus daemon.
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };

    # Enable the PostgreSQL daemon.
    postgresql.enable = true;

    # Enable the Xray daemon
    xray = {
      enable = true;
      settingsFile = /home/kirill/.config/xray/xray.json;
    };

    #openvpn.servers = {
    #labVPN  = { config = '' config /etc/nixos/starting_point_kiroris.ovpn ''; };
    #};

  };




# ██████╗ ██████╗  ██████╗  ██████╗ ██████╗  █████╗ ███╗   ███╗███████╗
# ██╔══██╗██╔══██╗██╔═══██╗██╔════╝ ██╔══██╗██╔══██╗████╗ ████║██╔════╝
# ██████╔╝██████╔╝██║   ██║██║  ███╗██████╔╝███████║██╔████╔██║███████╗
# ██╔═══╝ ██╔══██╗██║   ██║██║   ██║██╔══██╗██╔══██║██║╚██╔╝██║╚════██║
# ██║     ██║  ██║╚██████╔╝╚██████╔╝██║  ██║██║  ██║██║ ╚═╝ ██║███████║
# ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝




}





