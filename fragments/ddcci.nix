{ pkgs, ... }:
{

  # Fix ddcci on 6.10+ (temporary until the patch is merged and nixpkgs switches to a newer version)
  nixpkgs.overlays = [
        (self: super: {
            linuxPackages_latest = super.linuxPackages_latest.extend (lpself: lpsuper: {
                ddcci-driver = super.linuxPackages_latest.ddcci-driver.overrideAttrs (oldAttrs: {
                    version = super.linuxPackages_latest.ddcci-driver.version + "-FIXED";
                    patches = oldAttrs.patches ++ [ 
                      (pkgs.fetchpatch {
                        name = "ddcci-f53b127ca9d7fc0969c0ee3499d8c55aebfe8116.patch";
                        url = "https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux/-/commit/f53b127ca9d7fc0969c0ee3499d8c55aebfe8116.patch";
                        hash = "sha256-+5NiAyM0xRZnlqJSTw3oauTTC+XVwVQrr6uEoGQ6yhI=";
                      })

                      (pkgs.fetchpatch {
                        name = "ddcci-7853cbfc28bc62e87db79f612568b25315397dd0.patch";
                        url = "https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux/-/commit/7853cbfc28bc62e87db79f612568b25315397dd0.patch";
                        hash = "sha256-l5wFQb+xHd3mS9LlJHr33hQck8JjcVuSUK6blVE8HU8=";
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