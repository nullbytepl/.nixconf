{ config, pkgs, ... }:

{
  imports =
    [
      ../common.nix
      ../fragments/intel_platform.nix
    ];

    networking.hostName = "puppy";

    # Disable PCIe ASPM as it causes sleep issues
    boot.kernelParams = [ "pcie_aspm=off" ];

    # Connect to the Magic Keyboard as soon as possible (i.e. schedule the connection before sddm loads)
    # Don't block the boot process ('&')
    services.displayManager.sddm.setupScript = "${pkgs.bluez}/bin/bluetoothctl connect 48:E1:5C:C3:A5:04 &";
}