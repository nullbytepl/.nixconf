{ config, pkgs, ... }:
{
    # Change the keyboard to a more friendly layout
    boot.kernelParams = [
        "hid_apple.swap_opt_cmd=1"
    ];
}