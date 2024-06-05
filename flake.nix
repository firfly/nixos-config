{
  description = "Firfly's nixos configuration";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
  
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
  
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
  
    nix-gaming.url = "github:fufexan/nix-gaming";
  
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

 #   Neve.url = "github:firfly/Neve";

    # dae
    daeuniverse = {
      url = "github:daeuniverse/flake.nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  
    hyprland = {
#      url = "github:hyprwm/Hyprland";
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
 #     inputs.nixpkgs.follows = "nixpkgs";
    };
  
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-cava = {
      url = "github:catppuccin/cava";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
  };

  outputs = { nixpkgs, self, agenix, ...} @ inputs:
  let
    selfPkgs = import ./pkgs;
    username = "firfly";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in
  {
    overlays.default = selfPkgs.overlay;
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ 
		(import ./hosts/desktop) 
		agenix.nixosModules.default
		{ environment.systemPackages = [ agenix.packages.${system}.default ]; }
		inputs.daeuniverse.nixosModules.dae
                inputs.daeuniverse.nixosModules.daed
		];
        specialArgs = { host="desktop"; inherit self inputs username system ; };
      };
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ 
		(import ./hosts/laptop)
		agenix.nixosModules.default
		{ environment.systemPackages = [ agenix.packages.${system}.default ]; }
		inputs.daeuniverse.nixosModules.dae
                inputs.daeuniverse.nixosModules.daed
		];
        specialArgs = { host="laptop"; inherit self inputs username system ; };
      };
       vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ 
		(import ./hosts/vm)
		agenix.nixosModules.default
		{ environment.systemPackages = [ agenix.packages.${system}.default ]; }
		inputs.daeuniverse.nixosModules.dae
                inputs.daeuniverse.nixosModules.daed
		];
        specialArgs = { host="vm"; inherit self inputs username system ; };
      };
    };
  };
}
