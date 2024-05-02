pkgs: with pkgs; [
    # Basics
    kdePackages.kate
    pkgs.google-chrome
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
    pkgs.p7zip
    pkgs.nil # Nix language server
    pkgs.gnome.ghex
    pkgs.unzip

    # Misc
    pkgs.obs-studio
    pkgs.mpv
    kdePackages.ktorrent
    kdePackages.kdenlive
    pkgs.tor-browser
    pkgs.googleearth-pro

    # Misc development
    pkgs.jdk21
    pkgs.python311Full
    pkgs.python311Packages.pip
    pkgs.nodejs_22
    pkgs.qucs-s
    pkgs.dart
    pkgs.flutter

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
]
