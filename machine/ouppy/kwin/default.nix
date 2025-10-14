{ config, pkgs, ... }:
{

    environment.etc."kwinoutputconfig.json" = {
        source = ./kwinoutputconfig.json;
        user = "sddm";
        group = "sddm";
        mode = "777";
    };

    system.activationScripts.sddmCopyDisplayConfig.text = ''
        ln -sf /etc/kwinoutputconfig.json /var/lib/sddm/.config/kwinoutputconfig.json
  '';
}
