{ config, pkgs, ... }:

{
  imports =
    [
      ./base.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  users.users.kamila = {
    isNormalUser = true;
    description = "Kamila Wojciechowska";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = import ./user_packages.nix pkgs;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = import ./packages.nix pkgs;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # In case python2 is needed (for nix-shell usage)
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.7"
  ];

  # Git configuration
  programs.git = {
    enable = true;
    config = {
      user.name  = "Kamila Wojciechowska";
      user.email = "nullbytepl@gmail.com";
    };
  };
}
