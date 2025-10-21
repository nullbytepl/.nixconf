{ inputs, lib, config, pkgs, ... }:
{
  imports =
    [
      ./base.nix
      ./packages/global.nix
      ./fragments/sops.nix
      ./fragments/virtualbox.nix
      ./fragments/earth.nix
      ./fragments/steam.nix
      ./fragments/logi/logiops.nix
      ./fragments/magic_keyboard.nix
      ./fragments/bluetooth.nix
      ./fragments/adb.nix
      ./fragments/vesktop.nix
      ./fragments/flutter.nix
      ./fragments/chrome.nix
      ./fragments/avatar.nix
      ./fragments/ucode.nix
      ./fragments/wifi.nix

      # Common nixhardware configs; no platform-specific stuff to go here.
      inputs.nixhardware.nixosModules.common-hidpi
      inputs.nixhardware.nixosModules.common-pc-ssd
      inputs.nixhardware.nixosModules.common-pc
    ];

  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

  users.users.mila = {
    isNormalUser = true;
    description = "Mila Wojciechowska";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = import ./packages/user.nix pkgs;
    hashedPasswordFile = config.sops.secrets.password.path;

  };

  nixpkgs.config = {
    allowUnfree = true;
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

    settings.experimental-features = "nix-command flakes";
  };

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  programs.bash.shellAliases = {
    nixos-update-here = "sudo nix-channel --update && nix flake update && sudo nixos-rebuild switch --flake .";
    nixos-update = "pushd ~/.nixconf && nixos-update-here; popd";
    "7z" = "7zz";
  };

  services.fwupd.enable = true;
}
