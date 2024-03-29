pkgs: with pkgs; [
    # Basics
    kdePackages.kate
    pkgs.google-chrome
    pkgs.vscode.fhs
    pkgs.binutils
    pkgs.spotify
    pkgs.discord
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

    # Misc
    pkgs.obs-studio
    pkgs.vlc
    kdePackages.ktorrent

    # Misc development
    pkgs.jdk21
    pkgs.python311Full
    pkgs.python311Packages.pip
    pkgs.nodejs_21

    # Libraries & stuff
    pkgs.corefonts
    pkgs.fira-code

    # Android
    pkgs.android-studio
    pkgs.android-tools # This would be installed by android-studio, but it's nixos after all
    pkgs.git-repo
    pkgs.jadx
]
