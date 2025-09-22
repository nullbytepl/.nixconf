{ inputs, config, pkgs, ... }:
let
  sops = inputs.sops-nix;
  secrets = inputs.secrets.nixosModules;
in
{
  sops = {
    age.keyFile = "/home/mila/.config/sops/age/keys.txt";

    secrets = {
      password = {
        sopsFile = secrets.password;
        neededForUsers = true;
      };
    };
  };
}
