{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = lib.flatten [
    ./hardware-configuration.nix
    ./kwin
    ../../hw/nvidia.nix
    ../../hw/intel_platform.nix
    ../../hw/hiram.nix
    inputs.nixhardware.nixosModules.common-hidpi
    inputs.nixhardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixhardware.nixosModules.common-pc-ssd
    inputs.nixhardware.nixosModules.common-pc

    (import ../../common/fragments/kernel.nix { cpuArch = "alderlake"; useNv = true; inherit lib config pkgs; })
  ];

  # Connect to the Magic Keyboard as soon as possible (i.e. schedule the connection before sddm loads)
  # Don't block the boot process ('&')
  systemd.services.wayfuck = {
        serviceConfig = {
            ExecStart = ''${pkgs.bluez}/bin/bluetoothctl connect 48:E1:5C:C3:A5:04'';
            Restart = "no";
        };
        wantedBy = [ "multi-user.target" ];
        requires = [ "bluetooth.target" ];
    };

  # Force disable hibernation because it definitely ~DOES NOT~ work on this machine
  systemd.sleep.extraConfig = ''
    AllowHibernation=no
  '';

  networking.hostName = "ouppy";

  system.stateVersion = "25.05";
}
