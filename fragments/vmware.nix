{ config, pkgs, ... }:
{
    # The vmware kernel module is broken on 6.9.1, so use a patched fork until nixpkgs is updated
    nixpkgs.overlays = [
        (self: super: {
            linuxPackages_latest = super.linuxPackages_latest.extend (lpself: lpsuper: {
                vmware = super.linuxPackages_latest.vmware.overrideAttrs (oldAttrs: {
                    version = super.linuxPackages_latest.vmware.version + "-FIXED";
                    src = pkgs.fetchFromGitHub {
                        owner = "nan0desu";
                        repo = "vmware-host-modules";
                        rev = "d9f51eee7513715830ac214f1b25db79059f5270";
                        sha256 = "sha256-63ZYa3X3fVpJQuHoBuqP5fs64COAgjJ9iG9LNkXPXfw=";
                    };
                });
            });
        })
    ];

    environment.systemPackages = [
        pkgs.vmware-workstation
    ];

    # Required to run the kernel modules for vmware
    virtualisation.vmware.host.enable = true;
}