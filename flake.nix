{
  description = "Home Manager configuration of zell";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
        url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    obsidian-nvim = { url = "github:epwalsh/obsidian.nvim"; flake = false; };
    vimwiki = { url = "github:vimwiki/vimwiki"; flake = false; };    
# Star Citizen
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";
  };

  outputs = { nixpkgs, home-manager, self, nixos-hardware, ... }@inputs:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowunfree = true;};
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = import ./hosts/default.nix {
          inherit self nixpkgs inputs nixos-hardware ;
        } ;
      
      homeConfigurations."zell" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home-manager/home.nix 
        inputs.hyprland.homeManagerModules.default];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
