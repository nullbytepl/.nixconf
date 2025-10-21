{ config, pkgs, ... }:
{
    environment.systemPackages = [
        pkgs.intel-gpu-tools
    ];

    hardware.graphics = {
        extraPackages = with pkgs; [
            intel-media-driver
            vpl-gpu-rt
        ];
    };

    environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
}
