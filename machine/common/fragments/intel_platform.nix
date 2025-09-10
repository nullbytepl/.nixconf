{ config, pkgs, ... }:
{
    environment.systemPackages = [
        pkgs.intel-gpu-tools
    ];

    hardware.opengl = {
        extraPackages = with pkgs; [
            intel-media-driver
        ];
    };

    environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
}