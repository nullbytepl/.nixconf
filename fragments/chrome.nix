{ pkgs, ... }:
{
    environment.systemPackages = [
      (pkgs.google-chrome.override {
        commandLineArgs = [
          # Enable navigation gestures for touchpad
          "--enable-features=TouchpadOverscrollHistoryNavigation"
        ];
      })
    ];

    # Service to shut down chrome "gracefully" (so it doesn't show the "Chrome didn't shut down properly" message)
    # https://askubuntu.com/a/1469353
    systemd.services.murder_chrome = {
        serviceConfig = {
          # The killall in pkgs.toybox doesn't support `--wait`, so use pkgs.psmisc
          ExecStart = ''
            ${pkgs.psmisc}/bin/killall chrome --wait
          '';
          Type = "oneshot";
          User = "root";
          Group = "root";
          Restart = "no";
        };
        unitConfig = {
          DefaultDependencies = "no";
        };
        before = [ "shutdown.target" ];
        wantedBy = [ "halt.target" "reboot.target" "shutdown.target" ];
        enable = true;
    };
}