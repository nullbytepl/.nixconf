{ config, pkgs, ... }:
{
  programs.plasma = {
    enable = true;

    workspace.cursor.theme = "macOS";

    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    kwin.effects.wobblyWindows.enable = true;
  };

}
