{ pkgs, ... }:
{

  # Fix ddcci on 6.11+ (temporary until the patch is merged and nixpkgs switches to a newer version)
  nixpkgs.overlays = [
        (self: super: {
            linuxPackages_latest = super.linuxPackages_latest.extend (lpself: lpsuper: {
                ddcci-driver = super.linuxPackages_latest.ddcci-driver.overrideAttrs (oldAttrs: {
                    version = super.linuxPackages_latest.ddcci-driver.version + "-FIXED";

                    src = pkgs.fetchFromGitLab {
                      owner = "ddcci-driver-linux";
                      repo = "ddcci-driver-linux";
                      rev = "0233e1ee5eddb4b8a706464f3097bad5620b65f4";
                      hash = "sha256-Osvojt8UE+cenOuMoSY+T+sODTAAKkvY/XmBa5bQX88=";
                    };

                    patches = [ 
                      (pkgs.fetchpatch {
                        name = "ddcci-e0605c9cdff7bf3fe9587434614473ba8b7e5f63.patch";
                        url = "https://gitlab.com/nullbytepl/ddcci-driver-linux/-/commit/e0605c9cdff7bf3fe9587434614473ba8b7e5f63.patch";
                        hash = "sha256-sTq03HtWQBd7Wy4o1XbdmMjXQE2dG+1jajx4HtwBHjM=";
                      })
                     ];
                });
            });
        })
    ];

  boot.extraModulePackages = with pkgs; [
    linuxPackages_latest.ddcci-driver
  ];
}