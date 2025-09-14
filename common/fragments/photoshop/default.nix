{
  lib,
  mkWindowsApp,
  fetchurl,
  uiScale ? null,
  photoshopDir ? "Adobe Photoshop 2025",
  pkgs,
  makeDesktopItem,
  makeDesktopIcon, # This comes with erosanix. It's a handy way to generate desktop icons.
  copyDesktopItems,
  copyDesktopIcons, # This comes with erosanix. It's a handy way to generate desktop icons.
  unzip,
  ...
}:
let
  programDir = "$WINEPREFIX/drive_c/Program Files/Adobe";
  commonDir = "$WINEPREFIX/drive_c/Program Files (x86)/Common Files";
in
mkWindowsApp rec {
  wine = pkgs.wineWowPackages.stable;
  version = "2025";

  pname = "photoshop";
  dontUnpack = true;
  wineArch = "win64";
  enableMonoBootPrompt = false;

  fileMap = {
    "$XDG_CONFIG_HOME/${pname}/roaming" = "drive_c/users/$USER/AppData/Roaming/Adobe";
    "$XDG_CONFIG_HOME/${pname}/local" = "drive_c/users/$USER/AppData/Local/Adobe";
    "$XDG_CONFIG_HOME/${pname}/locallow" = "drive_c/users/$USER/AppData/LocalLow/Adobe";
  };

  src = ./ps.zip;

  enableVulkan = true;
  graphicsDriver = "auto";
  nativeBuildInputs = [
    unzip
    copyDesktopItems
    copyDesktopIcons
  ];

  winAppInstall =
    let
      setScale =
        if uiScale == null then
          ""
        else
          ''
            scaleRegFile=$(mktemp)
            (
              echo "REGEDIT4"
              echo
              echo "[HKEY_LOCAL_MACHINE\System\CurrentControlSet\Hardware Profiles\Current\Software\Fonts]"
              echo "\"LogPixels\"=dword:$(printf '%08x' "${uiScale}")"
            ) > $scaleRegFile
            regedit $scaleRegFile
          '';
    in
    ''
      winetricks --unattended corefonts win10 vkd3d dxvk2030 msxml3 msxml6 gdiplus \
        vcrun2003 vcrun2005 vcrun2010 vcrun2012 vcrun2013 vcrun2022

      mkdir -p "${programDir}"
      mkdir -p "${commonDir}"
      tmpdir=$(mktemp -d)
      unzip ${src} -d "$tmpdir"
      mv "$tmpdir/photoshop" "${programDir}/${photoshopDir}"
      mv "$tmpdir/common" "${commonDir}/Adobe"

      ${setScale}
    '';

  winAppRun = ''
    wine "${programDir}/${photoshopDir}/photoshop.exe" "$ARGS"
  '';

  # This code will run after winAppRun, but only for the first instance.
  # Therefore, if the app was already running, winAppPostRun will not execute.
  # In other words, winAppPostRun is only executed if winAppPreRun is executed.
  # Use this to do any cleanup after the app has terminated
  winAppPostRun = "";

  # This is a normal mkDerivation installPhase, with some caveats.
  # The launcher script will be installed at $out/bin/.launcher
  # DO NOT DELETE OR RENAME the launcher. Instead, link to it as shown.
  installPhase = ''
    runHook preInstall

    ln -s $out/bin/.launcher $out/bin/${pname}

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      mimeTypes = [
        "image/apng"
        "image/avif"
        "image/bmp"
        "image/gif"
        "image/jpeg"
        "image/png"
        "image/svg+xml"
        "image/tiff"
        "image/webp"
      ];

      name = pname;
      exec = pname;
      icon = pname;
      desktopName = "Adobe Photoshop";
      genericName = "Image Editor";
      categories = [
        "Graphics"
        "2DGraphics"
        "RasterGraphics"
        "Photography"
      ];
    })
  ];

  desktopIcon = makeDesktopIcon {
    name = "photoshop";

    src = fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Adobe_Photoshop_CC_icon.svg/512px-Adobe_Photoshop_CC_icon.svg.png";
      sha256 = "sha256-bQeCaZz64LfFFS5w1o5DcaTlJYH9vkMTw9gutpeF43k=";
    };
  };

  meta = {
    platforms = [ "x86_64-linux" ];
  };
}
