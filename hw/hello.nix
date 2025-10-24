# Windows Hello reimplementation for Linux
# https://github.com/pineapplehunter/howdy-module
# TODO: switch to the nixpkgs impl once https://github.com/NixOS/nixpkgs/pull/216245 gets merged

{ inputs, ... }:
{
  imports = [
    inputs.howdy-module.nixosModules.default
  ];

  services.howdy.enable = true;
  services.linux-enable-ir-emitter.enable = true;
}
