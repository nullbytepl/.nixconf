{ config, pkgs, ... }:
{
  programs.plasma = {
    enable = true;

    workspace.cursor.theme = "macOS";

    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    kwin.effects.wobblyWindows.enable = true;

    fonts =
    let
      inter = size: {
        family = "SF Pro Rounded";
        pointSize = size;
      };
    in
    {
      small = inter 8;
      general = inter 10;
      toolbar = inter 10;
      menu = inter 10;
      windowTitle = inter 10;

      fixedWidth = {
        family = "Fira Code";
        pointSize = 10;
      };
    };
  };

}
