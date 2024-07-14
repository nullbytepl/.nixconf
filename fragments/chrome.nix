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
}