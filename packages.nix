pkgs: with pkgs; [
    # Basics
    kdePackages.kate
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
    pkgs.ghex
    pkgs.unzip

    # Misc
    pkgs.obs-studio
    pkgs.mpv
    kdePackages.ktorrent
    kdePackages.kdenlive
    kdePackages.partitionmanager
    pkgs.tor-browser
    pkgs.googleearth-pro
    #pkgs.cura # <---- FUCK YOU
    pkgs.slack
    pkgs.axel

    # Misc development
    pkgs.jdk21
    pkgs.python311Full
    pkgs.python311Packages.pip
    pkgs.nodejs_23
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
]
