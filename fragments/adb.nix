{ config, pkgs, ... }:
{
  programs.adb.enable = true;
  users.users.kamila.extraGroups = ["adbusers" "kvm"];
}