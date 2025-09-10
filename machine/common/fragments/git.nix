{ config, pkgs, ... }:
{
    # Git configuration
    programs.git = {
        enable = true;
        config = {
            user.name  = "Mila Wojciechowska";
            user.email = "nullbytepl@gmail.com";
        };
    };
}
