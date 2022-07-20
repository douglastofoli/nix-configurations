{
  description = "My Personal NixOS System Flake Configuration";

  inputs =                                                                  # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";                  # Nix Packages

      home-manager = {                                                      # User Package Management
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {
        url = "github:nix-community/NUR";                                   # NUR packages
      };

      nixgl = {                                                             #OpenGL 
        url = "github:guibou/nixGL";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, nixgl, ... }:   # Function that tells my flake which to use and what do what to do with the dependencies.
    let                                                                     # Variables that can be used in the config files.
      user = "douglas";
      location = "$HOME/.flake";
      protocol = "X";         # Desktop choice "X" and "Wayland" | Laptop ONLY choice "Wayland"
    in                                                                      # Use above variables in ...
    {
      nixosConfigurations = (                                               # NixOS configurations
        import ./hosts {                                                    # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user location protocol;   # Also inherit home-manager so it does not need to be defined here.
        }
      );

      homeConfigurations = (                                                # Non-NixOS configurations
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nixgl user;
        }
      );
    };
}
