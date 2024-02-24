{
  description = "HyprGrape";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grape-neovim.url = "github:grapeofwrath/nixvim-flake";
  };

  outputs = inputs@{ nixpkgs, home-manager, grape-neovim, ... }:
  let
    system = "x86_64-linux";

    # User Variables
    hostname = "hyprnix";
    username = "marcus";
    theLocale = "en_US.UTF-8";
    theKBDLayout = "us";
    theLCVariables = "en_US.UTF-8";
    theTimezone = "America/Chicago";
    wallpaperGit = "https://github.com/grapeofwrath/wallpapers.git";
    wallpaperDir = "/home/${username}/Pictures/Wallpapers";
    flakeDir = "/home/${username}/hyprgrape";
    # Driver selection profile
    # Options include amd (tested), intel, nvidia
    # GPU hybrid options: intel-nvidia, intel-amd
    # vm for both if you are running a vm
    cpuType = "amd";
    gpuType = "amd";
    # sudo lshw -c display
    # This is needed ONLY for hybrid nvidia offloading
    # Run: nvidia-offload (insert program name)
    intel-bus-id = "PCI:0:2:0";
    nvidia-bus-id = "PCI:14:0:0";

    pkgs = import nixpkgs {
      inherit system;
      config = {
	allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
	specialArgs = { 
          inherit system; inherit inputs; 
          inherit hostname;
          inherit theTimezone;
          inherit theLocale;
          inherit wallpaperDir; inherit wallpaperGit;
          inherit cpuType; inherit theKBDLayout;
          inherit theLCVariables; inherit gpuType;
        };
	modules = [ ./system.nix
          home-manager.nixosModules.home-manager {
	    home-manager.extraSpecialArgs = { inherit username; 
              inherit inputs;
              inherit wallpaperDir;
              inherit wallpaperGit; inherit flakeDir;
              inherit gpuType; inherit cpuType;
              inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
            };
	    home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
	    home-manager.users.marcus = import ./home.nix;
	  }
	];
      };
    };
  };
}
