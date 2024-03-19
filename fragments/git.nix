{ config, pkgs, ... }:
{
    # Git configuration
    programs.git = {
        enable = true;
        config = {
            user.name  = "Kamila Wojciechowska";
            user.email = "nullbytepl@gmail.com";
        };
    };
}