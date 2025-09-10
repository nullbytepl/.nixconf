{ config, pkgs, ... }:
{
    environment.systemPackages = [
        pkgs.vesktop
        pkgs.arrpc
    ];

    systemd.services.arrpc = {
        serviceConfig = {
            ExecStart = ''
                ${pkgs.arrpc}/bin/arrpc
            '';
            Restart = "on-failure";
            RestartSec = 5;
        };
        wantedBy = [ "default.target" ];
    };
}