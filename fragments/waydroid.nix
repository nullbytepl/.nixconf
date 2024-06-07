{ pkgs,... }:
{
  virtualisation.waydroid.enable = true;

  # Service to start a Waydroid session on boot
  systemd.services.waydroid = {
    description = "Waydroid";
    wantedBy = [ "graphical-session.target" ];

    partOf = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.waydroid}/bin/waydroid session start";
      ExecStop = "${pkgs.waydroid}/bin/waydroid session stop";
    };
  };
}