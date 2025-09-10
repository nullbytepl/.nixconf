{ inputs, config, pkgs, ... }:
{
  imports =
    [
      ./base.nix
      #./fragments/vmware.nix
      ./fragments/git.nix
      ./fragments/steam.nix
      ./fragments/logi/logiops.nix
      ./fragments/magic_keyboard.nix
      ./fragments/bluetooth.nix
      ./fragments/adb.nix
      ./fragments/vesktop.nix
      ./fragments/flutter.nix
      ./fragments/chrome.nix
      ./fragments/ucode.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  users.users.mila = {
    isNormalUser = true;
    description = "Mila Wojciechowska";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = import ./user_packages.nix pkgs;
  };

  nixpkgs.config = {
    allowUnfree = true;

    # Needs to be in the top-level config
    # Ugly, but it works
    permittedInsecurePackages = [
      "googleearth-pro-7.3.4.8248"
      "googleearth-pro-7.3.6.9796"
      "googleearth-pro-7.3.6.10201"
    ];
  };

  nix = {
    registry = {
      nixpkgs = {
        flake = inputs.nixpkgs;
      };
    };

    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
      "/home/mila/.nixconf/"
    ];
  };

  environment.systemPackages = import ./packages.nix pkgs;

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };
}
