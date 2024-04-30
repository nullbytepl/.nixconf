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
      ./fragments/vesktop.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  users.users.kamila = {
    isNormalUser = true;
    description = "Kamila Wojciechowska";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = import ./user_packages.nix pkgs;
  };

  nixpkgs.config = {
    allowUnfree = true;

    # Needs to be in the top-level config
    # Ugly, but it works
    permittedInsecurePackages = [
      "googleearth-pro-7.3.4.8248"
    ];
  };

  environment.systemPackages = import ./packages.nix pkgs;
}
