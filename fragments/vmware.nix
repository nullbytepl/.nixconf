{ config, pkgs, ... }:
{
    environment.systemPackages = [
        pkgs.vmware-workstation
    ];

    # Required to run the kernel modules for vmware
    virtualisation.vmware.host.enable = true;
}