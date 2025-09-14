{
  inputs,
  lib,
  ...
}:
{
  imports = lib.flatten [
    ./hardware-configuration.nix
    ./es83xx/audio.nix
    inputs.nixhardware.nixosModules.common-hidpi
    inputs.nixhardware.nixosModules.common-cpu-amd
    inputs.nixhardware.nixosModules.common-cpu-amd-pstate
    inputs.nixhardware.nixosModules.common-cpu-amd-zenpower
    inputs.nixhardware.nixosModules.common-pc-laptop-ssd
    inputs.nixhardware.nixosModules.common-pc-laptop
  ];

  networking.hostName = "enbusia";

  system.stateVersion = "25.05";
}
