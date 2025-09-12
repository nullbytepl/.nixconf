{
  inputs,
  lib,
  pkgs,
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

  boot.kernelParams = [ "pcie_aspm=off" ];

  # Connect to the Magic Keyboard as soon as possible (i.e. schedule the connection before sddm loads)
  # Don't block the boot process ('&')
  services.xserver.displayManager.setupCommands = ''

      ${pkgs.bluez}/bin/bluetoothctl connect 48:E1:5C:C3:A5:04 &
    '';

  networking.hostName = "ouppy";

  system.stateVersion = "25.05";
}
