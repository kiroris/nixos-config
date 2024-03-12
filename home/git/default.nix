{ pkgs,  ... }: {

#  ██████╗ ██╗████████╗
# ██╔════╝ ██║╚══██╔══╝
# ██║  ███╗██║   ██║   
# ██║   ██║██║   ██║   
# ╚██████╔╝██║   ██║   
#  ╚═════╝ ╚═╝   ╚═╝   
  programs.git = {
    enable = true;
    userName = "kiroris";
    userEmail = "kiroris@proton.me";
    aliases = {
      co = "checkout";
      ci = "commit";
      s = "status";
    };
  };
}
