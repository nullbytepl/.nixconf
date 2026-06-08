{ pkgs, inputs, ... }:
let
  copyDesktopIcons = inputs.erosanix.lib."${pkgs.stdenv.hostPlatform.system}".copyDesktopIcons;
  copyDesktopItems = inputs.erosanix.lib."${pkgs.stdenv.hostPlatform.system}".copyDesktopIcons;
  makeDesktopIcon = inputs.erosanix.lib."${pkgs.stdenv.hostPlatform.system}".makeDesktopIcon;
  mkWindowsApp = inputs.erosanix.lib."${pkgs.stdenv.hostPlatform.system}".mkWindowsApp;
in
{
  ltspice = pkgs.callPackage ./ltspice.nix { inherit pkgs mkWindowsApp; };
  idapro = pkgs.callPackage ./idapro.nix { inherit pkgs makeDesktopIcon; };
}
