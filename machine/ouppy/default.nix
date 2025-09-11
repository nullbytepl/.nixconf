{
  inputs,
  lib,
  ...
}:
{
  imports = lib.flatten [
    ./hardware-configuration.nix
    ../../hw/nvidia.nix
    #../../hw/intel_platform.nix # TODO: Restore after setting up PRIME
    inputs.nixhardware.nixosModules.common-hidpi
    inputs.nixhardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixhardware.nixosModules.common-pc-ssd
    inputs.nixhardware.nixosModules.common-pc
    ../common
  ];

  networking.hostName = "ouppy";

  system.stateVersion = "25.05";
}
