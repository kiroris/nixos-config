{ pkgs, config, ... }: {
  programs.home-manager.enable = true;

# ██╗  ██╗ ██████╗ ███╗   ███╗███████╗    ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗ 
# ██║  ██║██╔═══██╗████╗ ████║██╔════╝    ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗
# ███████║██║   ██║██╔████╔██║█████╗█████╗██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝
# ██╔══██║██║   ██║██║╚██╔╝██║██╔══╝╚════╝██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗
# ██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗    ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║
# ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
  imports = [
    ./git
  ];


  home = {
    username = "kirill";
    homeDirectory = "/home/kirill";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      DEFAULT_USER = "$(whoami)";
    };
  };

  systemd.user = {
    startServices = "sd-switch";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  home.packages = with pkgs; [
    fastfetch
  ];

  home.pointerCursor = {
    name = "Adwaita";
    size = 24;
    package = pkgs.gnome3.adwaita-icon-theme;
  };






    xdg.configFile = {
    fastfetch = {
      source = ./files/fastfetch.jsonc;
      target = "fastfetch/config.jsonc";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.stateVersion = "23.05";
}
