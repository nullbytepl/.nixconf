{ config, pkgs, ... }:

{
  imports =
    [
      ../common.nix
    ];

    networking.hostName = "puppy";

    # Disable PCIe ASPM as it causes sleep issues
    boot.kernelParams = [ "pcie_aspm=off" ];
}