{ pkgs, inputs, ... }:
{
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    hinting = "full";
    subpixelRendering = "rgb";
  };

  home.packages = [
    pkgs.corefonts
    pkgs.vistafonts
    pkgs.fira-code
    pkgs.fira-code-symbols
    pkgs.inter
    pkgs.lato
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-emoji
    pkgs.roboto
    pkgs.liberation_ttf
    pkgs.dejavu_fonts
    pkgs.roboto-serif
    inputs.apple-fonts.packages."x86_64-linux".sf-pro
    inputs.apple-fonts.packages."x86_64-linux".sf-compact
    inputs.apple-fonts.packages."x86_64-linux".sf-mono
    inputs.apple-fonts.packages."x86_64-linux".ny
  ];
}
