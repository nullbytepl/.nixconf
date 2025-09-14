{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

        nixhardware.url = "github:nixos/nixos-hardware";

        ucodenix.url = "github:e-tho/ucodenix";
    };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixhardware, ucodenix }@inputs:
  let
    lib = nixpkgs.lib;
    in
  {

    nixosConfigurations =
        with builtins;
        let
          machines = lib.remove "common" (attrNames (readDir ./machine));
        in
        listToAttrs (
          map (machine: {
            name = machine;
            value = nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs outputs lib;
              };
              modules = [ ./machine/${machine} ];
            };
          }) machines
        );
  };
}
