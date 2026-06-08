{ config, pkgs, ... }:
{
  users.users.mila.extraGroups = ["adbusers" "kvm"];
}
