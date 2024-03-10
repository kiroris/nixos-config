{ pkgs, config, lib, ... }:@inputs {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

# ██████╗  ██████╗  ██████╗ ████████╗
# ██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝
# ██████╔╝██║   ██║██║   ██║   ██║   
# ██╔══██╗██║   ██║██║   ██║   ██║   
# ██████╔╝╚██████╔╝╚██████╔╝   ██║   
# ╚═════╝  ╚═════╝  ╚═════╝    ╚═╝  
  #boot = {
  #  loader = {
  #    systemd-boot.enable = true;
  #    efi.canTouchEfiVariables = true;
  #  };
  #  kernelPackages = pkgs.linuxPackages_latest;
  #};
}
