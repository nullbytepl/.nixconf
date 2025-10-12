{ pkgs, inputs, ... }:
let
  custom = import ../../packages { inherit pkgs inputs; };
in
{
  environment.systemPackages = [
    # Basics
    pkgs.kdePackages.kate
    pkgs.vscode.fhs
    pkgs.binutils
    pkgs.spotify
    pkgs.hyfetch
    pkgs.telegram-desktop

    # Utils
    pkgs.usbutils
    pkgs.pciutils
    pkgs.htop
    pkgs.s-tui
    pkgs.file
    pkgs.wget
    pkgs.zip
    pkgs._7zz
    pkgs.nil # Nix language server
    pkgs.ghex
    pkgs.unzip

    # Misc
    pkgs.obs-studio
    pkgs.mpv
    pkgs.kdePackages.ktorrent
    pkgs.kdePackages.kdenlive
    pkgs.kdePackages.partitionmanager
    pkgs.tor-browser
    pkgs.googleearth-pro
    pkgs.cura-appimage
    pkgs.slack
    pkgs.axel
    pkgs.alsa-utils
    pkgs.cowsay
    pkgs.sl
    pkgs.age
    pkgs.sops
    pkgs.ffmpeg-full
    pkgs.qgis-ltr

    # Misc development
    pkgs.jdk21
    pkgs.python311Full
    pkgs.python311Packages.pip
    pkgs.nodejs_24
    pkgs.qucs-s
    pkgs.dart
    pkgs.patchelf
    pkgs.dtc
    pkgs.binwalk
    pkgs.lz4
    pkgs.apktool
    pkgs.uefitool
    pkgs.dos2unix
    pkgs.typescript

    # Libraries & stuff
    pkgs.corefonts
    pkgs.vistafonts
    pkgs.fira-code
    pkgs.apple-cursor

    # Android
    pkgs.android-studio
    pkgs.android-tools # This would be installed by android-studio, but it's nixos after all
    pkgs.git-repo
    pkgs.jadx

    custom.ltspice
    custom.idapro
  ];
}
