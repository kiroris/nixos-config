{
  inputs = {
    
    # Nixpkgs
    #nixpkgs.url = "nixpkgs/nixos-unstable";
    #nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-Vim
    nixvim.url = "github:nix-community/nixvim";

    # Age-Nix
    agenix.url = "github:ryantm/agenix";

  };

  outputs = { self, nixpkgs, nixvim, agenix, ... }@inputs: {
    nixosConfigurations =
      let
        makeNixosConfiguration = name: modules: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ({ ... }: { networking.hostName = name; })
            ./system
          ] ++ modules;
        };
      in      
      {
        fallback = makeNixosConfiguration "fallback-hostname" [ ];

        wisteria = makeNixosConfiguration "wisteria" [
          ./configuration.nix
        ];

        lycoris = makeNixosConfiguration "lycoris" [
          ./configuration.nix
        ];
      };

#    homeConfigurations =







  };
}
