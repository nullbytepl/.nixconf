{ pkgs, inputs, ... }:
let
  copyDesktopIcons = inputs.erosanix.lib."${pkgs.system}".copyDesktopIcons;
  copyDesktopItems = inputs.erosanix.lib."${pkgs.system}".copyDesktopIcons;
  makeDesktopIcon = inputs.erosanix.lib."${pkgs.system}".makeDesktopIcon;
  mkWindowsApp = inputs.erosanix.lib."${pkgs.system}".mkWindowsApp;
in
{
  ltspice = pkgs.callPackage ./ltspice.nix { inherit pkgs mkWindowsApp; };
  idapro = pkgs.callPackage ./idapro.nix { inherit pkgs makeDesktopIcon; };
}
