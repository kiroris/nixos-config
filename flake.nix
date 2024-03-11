{
  inputs = {
    
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";
    #nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-Vim
    nixvim.url = "github:nix-community/nixvim";

    # Age-Nix
    agenix.url = "github:ryantm/agenix";

    # Nix-Index-db
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, nixvim, agenix, nix-index-database, ... }@inputs: {
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
          ./system/wisteria
          ./configuration.nix
        ];

        lycoris = makeNixosConfiguration "lycoris" [
          #./configuration.nix
        ];
      };

    homeConfigurations =
      let
        makeHomeConfiguration = modules: home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home
            #./home/gui
            #nixvim.homeManagerModules.nixvim
            #nix-index-database.hmModules.nix-index
          ] ++ modules;
        };
      in
      {
        "kirill@fallback-hostname" = makeHomeConfiguration [ ];

        "kirill@wisteria" = makeHomeConfiguration [
          #agenix.homeManagerModules.age
        ];

        "kirill@lycoris" = makeHomeConfiguration [
          #agenix.homeManagerModules.age
        ];
      };
  };
}
