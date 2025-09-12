{ config, pkgs, ... }:
{
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
    enableKvm = true;
    addNetworkInterface = false;
  };

  users.extraGroups.vboxusers.members = [ "mila" ];

  environment.systemPackages = [
    pkgs.virtualboxKvm
  ];
}
