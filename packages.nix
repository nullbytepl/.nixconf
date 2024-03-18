pkgs: with pkgs; [
    # Basics
    kate
    pkgs.google-chrome
    pkgs.vscode
    pkgs.git
    pkgs.binutils
    pkgs.spotify
    pkgs.discord
    pkgs.hyfetch

    # Utils
    pkgs.usbutils
    pkgs.pciutils
    pkgs.htop
    pkgs.s-tui

    # Misc
    pkgs.obs-studio
    pkgs.vlc
    ktorrent

    # Misc development
    pkgs.jdk21
    pkgs.python311Full
    pkgs.python311Packages.pip
    pkgs.pipx
    pkgs.nodejs
    pkgs.nodejs_21

    # Libraries & stuff
    pkgs.corefonts
    pkgs.fira-code

    # Android
    pkgs.android-studio
    pkgs.android-tools # This would be installed by android-studio, but it's nixos after all
]
