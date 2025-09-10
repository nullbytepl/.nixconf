{
  pkgs,
  ...
}:
let
  alsa-ucm-conf-es83xx =
      with pkgs;
      alsa-ucm-conf.overrideAttrs {
        name = alsa-ucm-conf.name + "-patched-es83xx";
        es83xxSrc = ./HiFi-es83xx.conf;
        postInstall = ''
          cp $es83xxSrc $out/share/alsa/ucm2/AMD/acp3x-es83xx/HiFi.conf
        '';
      };
in
{
  environment = {
    systemPackages = [
      alsa-ucm-conf-es83xx
    ];
    sessionVariables = {
      ALSA_CONFIG_UCM2 = "${alsa-ucm-conf-es83xx}/share/alsa/ucm2";
    };
  };
}
