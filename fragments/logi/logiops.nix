{ config, pkgs, ... }:
{
    environment.systemPackages = [
        pkgs.logiops
    ];

    environment.etc."logid.cfg".source = ./logid.cfg;

    systemd.services.logid = {
        serviceConfig = {
            ExecStart = ''
                ${pkgs.logiops}/bin/logid -c /etc/logid.cfg
            '';
            Restart = "always";
        };
        wantedBy = [ "default.target" ];
    };
}