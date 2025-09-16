{ config, pkgs, ... }:
{
  programs.plasma = {
    enable = true;

    workspace.cursor.theme = "macOS";
  };

}
