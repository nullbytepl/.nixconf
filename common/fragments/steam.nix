{ config, pkgs, ... }:
{
    # Steam
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

        extraCompatPackages = [
            pkgs.proton-ge-bin
        ];
    };

    # NTSYNC support for proton
    boot.kernelModules = ["ntsync"];

    services.udev.packages = [
        (pkgs.writeTextFile {
            name = "ntsync-udev-rules";
            text = ''KERNEL=="ntsync", MODE="0660", TAG+="uaccess"'';
            destination = "/etc/udev/rules.d/70-ntsync.rules";
        })
    ];
}
