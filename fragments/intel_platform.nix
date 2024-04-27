{ config, pkgs, ... }:
{
    environment.systemPackages = [
        pkgs.intel-gpu-tools
    ];

}