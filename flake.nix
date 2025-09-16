{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

        nixhardware.url = "github:nixos/nixos-hardware";

        ucodenix.url = "github:e-tho/ucodenix";

        erosanix.url = "github:emmanuelrosa/erosanix";

        home-manager = {
          url = "github:nix-community/home-manager/release-25.05";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        plasma-manager = {
          url = "github:nix-community/plasma-manager";
          inputs.nixpkgs.follows = "nixpkgs";
          inputs.home-manager.follows = "home-manager";
        };
    };

  outputs = { self,
    nixpkgs,
    nixpkgs-unstable,
    nixhardware,
    ucodenix,
    erosanix,
    home-manager,
    plasma-manager
  }@inputs:
  let
    lib = nixpkgs.lib;
    in
  {

    nixosConfigurations =
        with builtins;
        let
          machines = attrNames (readDir ./machine);
        in
        listToAttrs (
          map (machine: {
            name = machine;
            value = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs outputs lib;
              };
              modules = [
                ./machine/${machine}
                ./common
                home-manager.nixosModules.home-manager {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                  home-manager.users.mila = import ./home/mila.nix;
                }
              ];
            };
          }) machines
        );
  };

}
