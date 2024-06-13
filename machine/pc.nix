{ config, pkgs, ... }:

{
  imports =
    [
      ../common.nix
      ../fragments/intel_platform.nix
      ../fragments/ddcci.nix
    ];

    networking.hostName = "puppy";

    # Disable PCIe ASPM as it causes sleep issues
    boot.kernelParams = [ "pcie_aspm=off" ];

    
    services.displayManager.sddm.setupScript = ''
      # Connect to the Magic Keyboard as soon as possible (i.e. schedule the connection before sddm loads)
      # Don't block the boot process ('&')
      ${pkgs.bluez}/bin/bluetoothctl connect 48:E1:5C:C3:A5:04 &

      # Create the DDCCI device for the monitor
      echo 'ddcci 0x37' > /sys/class/drm/card1-DP-1/i2c-10/new_device &
      ${pkgs.kmod}/bin/modprobe ddcci_backlight &
    '';
}