{ config, pkgs, ... }:
{
  programs.adb.enable = true;
  users.users.mila.extraGroups = ["adbusers" "kvm"];
}
