{ config, pkgs, ... }:

{
  imports =
    [
      ../common.nix
      ../fragments/intel_platform.nix
      ../fragments/xe_4680.nix
    ];

    networking.hostName = "puppy";

    # Disable PCIe ASPM as it causes sleep issues
    boot.kernelParams = [ "pcie_aspm=off" ];
}