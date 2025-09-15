{ pkgs, inputs, ... }:
let
  copyDesktopIcons = inputs.erosanix.lib."${pkgs.system}".copyDesktopIcons;
  copyDesktopItems = inputs.erosanix.lib."${pkgs.system}".copyDesktopIcons;
  mkWindowsApp = inputs.erosanix.lib."${pkgs.system}".mkWindowsApp;
in
{
  ltspice = pkgs.callPackage ./ltspice.nix { inherit pkgs mkWindowsApp; };
}
