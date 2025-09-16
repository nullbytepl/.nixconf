{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      # Just install, who cares about vulnerabilities in fucking Google Earth
      googleearth-pro = super.googleearth-pro.overrideAttrs ( _: { meta.knownVulnerabilities = []; } );
    })
  ];
}
