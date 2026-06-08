{ pkgs, inputs, ... }:
{
    nixpkgs.overlays = [ inputs.affinity-nix.overlays.default ];

    environment.systemPackages = [
      pkgs.affinity-v3
    ];
}
