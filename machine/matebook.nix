{ config, pkgs, ... }:

{
  imports =
    [
      ../common.nix
    ];

    networking.hostName = "gay";
}