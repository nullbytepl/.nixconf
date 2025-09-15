{ config, pkgs, ... }:
{
  imports =
    [
      ./hyfetch.nix
    ];

  home.username = "mila";
  home.homeDirectory = "/home/mila";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
