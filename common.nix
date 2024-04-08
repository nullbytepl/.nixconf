{ config, pkgs, ... }:
{
  imports =
    [
      ./base.nix
      ./fragments/vmware.nix
      ./fragments/git.nix
      ./fragments/steam.nix
      ./fragments/logi/logiops.nix
      ./fragments/magic_keyboard.nix
      ./fragments/bluetooth.nix
      ./fragments/adb.nix
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

  # In case python2 is needed (for nix-shell usage)
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.7"
  ];
}
