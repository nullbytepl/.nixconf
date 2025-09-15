{ config, pkgs, ... }:
{
  programs.hyfetch = {
    enable = true;

    settings = {
      preset = "nonbinary";
      mode = "rgb";

      color_align = {
        mode = "vertical";
      };

      light_dark = "dark";
      lightness = 0.65;
    };
  };
}
