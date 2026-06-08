{ config, pkgs, ... }:
{
  # Git configuration
  programs.git = {
    enable = true;
    settings.user = {
        name = "Mila Wojciechowska";
        email = "nullbytepl@gmail.com";
    };
  };
}
