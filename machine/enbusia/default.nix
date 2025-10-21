{
  nixpkgs,
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
{
  imports = lib.flatten [
    ./hardware-configuration.nix
    ./es83xx/audio.nix
    inputs.nixhardware.nixosModules.common-cpu-amd
    inputs.nixhardware.nixosModules.common-cpu-amd-pstate
    inputs.nixhardware.nixosModules.common-cpu-amd-zenpower
  ];

  networking.hostName = "enbusia";

  system.stateVersion = "25.05";
}
