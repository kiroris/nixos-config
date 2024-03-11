{ pkgs,  ... }: {
  programs.git = {
    enable = true;
    userName = "kiroris";
    userEmail = "kiroris@proton.me";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
    extraConfig = ''
    init.defaultBranch = "main";
    ''
  };
}
