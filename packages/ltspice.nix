{
  fetchurl,
  makeDesktopItem,
  pkgs,
  mkWindowsApp,
  ...
}:
mkWindowsApp rec {
  wine = pkgs.wineWow64Packages.stable;
  pname = "ltspice";
  version = "26.0.2";

  src = fetchurl {
    url = "https://ltspice.analog.com/download/${version}/LTspice64.msi";
    sha256 = "sha256-SF2r0tfYKT3nM6OZcZ9lOO/aSlS0ixgaFOBycRhphNM=";
  };

  dontUnpack = true;

  winAppInstall = ''
    winetricks --unattended corefonts win10 gdiplus fontsmooth=rgb

    echo ${src}
    wine msiexec /i ${src} /qn
  '';

  winAppRun = ''
    wine start /unix "$WINEPREFIX/drive_c/Program Files/ADI/LTspice/LTspice.exe" "$ARGS"
  '';

  installPhase = ''
    runHook preInstall

    ln -s $out/bin/.launcher $out/bin/${pname}

    runHook postInstall
  '';

  fileMap = {
    "$HOME/.config/${pname}/" = "drive_c/users/$USER/AppData/Local/LTspice";
    "$HOME/.config/${pname}/tracking/" = "drive_c/users/$USER/AppData/Local/AdvinstAnalytics";
  };

  persistRegistry = true;

  wineArch = "win64";
  enableInstallNotification = true;

  desktopItems = [
    (makeDesktopItem {
      name = pname;
      exec = pname;
      desktopName = "LTspice";
      genericName = "Circuit editor and simulator.";
      categories = [
        "Science"
        "Development"
      ];
    })
  ];
}
