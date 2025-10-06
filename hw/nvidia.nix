{
  config,
  pkgs,
  ...
}:
{
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    #powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.latest;

    prime = {
      intelBusId = "PCI:1:0:0";
      nvidiaBusId = "PCI:0:2:0";

      sync.enable = true;
    };
  };
}
