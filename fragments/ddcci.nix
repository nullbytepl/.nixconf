{ pkgs, ... }:
{
  boot.extraModulePackages = with pkgs; [
    linuxPackages_latest.ddcci-driver
  ];
}