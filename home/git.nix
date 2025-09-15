{ config, pkgs, ... }:
{
  # Git configuration
  programs.git = {
    enable = true;
    userName = "Mila Wojciechowska";
    userEmail = "nullbytepl@gmail.com";
  };
}
