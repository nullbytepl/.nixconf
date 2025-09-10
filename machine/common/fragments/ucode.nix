{ inputs, ... }:
{
    imports = [ inputs.ucodenix.nixosModules.default ];

    # Update ucode automatically for CPUs not in linux-firmware
    services.ucodenix.enable = true;

    # Disable checksum verification
    boot.kernelParams = [ "microcode.amd_sha_check=off" ];
}
