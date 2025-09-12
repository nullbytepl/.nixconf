{ config, pkgs, ... }:
{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  users.extraGroups.vboxusers.members = [ "mila" ];

  environment.systemPackages = [
    pkgs.virtualboxKvm
  ];
}
