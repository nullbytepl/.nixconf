{ ... }:
{
  imports =
    [
      ./hyfetch.nix
      ./git.nix
      ./plasma.nix
      ./fonts.nix
    ];

  home.username = "mila";
  home.homeDirectory = "/home/mila";

  home.stateVersion = "25.05";

  home.file = {
    ".face.icon" = {
      source = builtins.fetchurl {
        url = "https://gravatar.com/avatar/${builtins.hashString "sha256" "nullbytepl@gmail.com"}?size=256";
        sha256 = "sha256:00zsm32ddqv0m7j6ijr6z6zrx8x1i79p0dsqznf5hxcsi2a6frlw";
        name = ".face.icon";
      };
    };
  };

  programs.home-manager.enable = true;
}
