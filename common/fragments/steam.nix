{ config, pkgs, ... }:
{
    nixpkgs.overlays = [
        (self: super: {
            proton-ge-bin = super.proton-ge-bin.overrideAttrs (old: rec {
                version = "GE-Proton10-21";
                src = super.fetchzip {
                    url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}.tar.gz";
                    hash = "sha256-Oa9+DjEeZZiJEr9H7wnUtGb6v/JXHk0qt0GAGcp3JFQ=";
                };
            });
        })
    ];

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
