{ ... }:
{
    boot.initrd.kernelModules = [ "xe" ];
    boot.kernelParams = [ "xe.force_probe=4680" ];
    services.xserver.videoDrivers = [ "xe" ];
}