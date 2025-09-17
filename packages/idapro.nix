{
  pkgs,
  lib,
  fetchtorrent,
  fetchurl,
  makeDesktopIcon,
  ...
}:
let
  ida91-bit = fetchtorrent {
    backend = "rqbit";
    url = "magnet:?xt=urn:btih:f24cfadb8a66b343bf1ff4f0c1386a5f6991c818&dn=ida91";
    hash = "sha256-B3zzhmQ0M39Xfg0i6KOHwCx4HJqny74ShXf870ahQo4=";
  };
  pythonForIDA = pkgs.python313.withPackages (ps: with ps; [ rpyc ]);
in
pkgs.stdenv.mkDerivation rec {
  pname = "ida-pro";
  version = "9.1.0.250226";

  src = "${ida91-bit}/ida91/ida-pro_91_x64linux.run";

  srcWdfPlugin = pkgs.fetchFromGitHub {
    owner = "thalium";
    repo = "ida_kmdf";
    rev ="01eb81aad4bf9df17294305b611fb9abacc2179e";
    hash = "sha256-57azcpL21VNv0ZyxrsUtYczA2vZyB60vCbWF24DEE/c=";
  };

  desktopItem = pkgs.makeDesktopItem {
    name = "ida-pro";
    exec = "ida";
    icon = "idapro";
    comment = meta.description;
    desktopName = "IDA Pro";
    genericName = "Interactive Disassembler";
    categories = [ "Development" ];
    startupWMClass = "IDA";
  };
  desktopItems = [ desktopItem ];

  nativeBuildInputs = with pkgs; [
    makeWrapper
    copyDesktopItems
    autoPatchelfHook
    libsForQt5.wrapQtAppsHook
  ];

  # We just get a runfile in $src, so no need to unpack it.
  dontUnpack = true;

  # Add everything to the RPATH, in case IDA decides to dlopen things.
  runtimeDependencies = with pkgs; [
    cairo
    dbus
    fontconfig
    freetype
    glib
    gtk3
    libdrm
    libGL
    libkrb5
    libsecret
    libsForQt5.qtbase
    libunwind
    libxkbcommon
    libsecret
    openssl.out
    stdenv.cc.cc
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libXau
    xorg.libxcb
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    zlib
    curl.out
    pythonForIDA
  ];
  buildInputs = runtimeDependencies;

  dontWrapQtApps = true;

  installPhase = ''
    runHook preInstall

    function print_debug_info() {
      if [ -f installbuilder_installer.log ]; then
        cat installbuilder_installer.log
      else
        echo "No debug information available."
      fi
    }

    trap print_debug_info EXIT

    mkdir -p $out/bin $out/lib $out/opt/.local/share/applications

    # IDA depends on quite some things extracted by the runfile, so first extract everything
    # into $out/opt, then remove the unnecessary files and directories.
    IDADIR="$out/opt"
    # IDA doesn't always honor `--prefix`, so we need to hack and set $HOME here.
    HOME="$out/opt"

    # Invoke the installer with the dynamic loader directly, avoiding the need
    # to copy it to fix permissions and patch the executable.
    $(cat $NIX_CC/nix-support/dynamic-linker) $src \
      --mode unattended --debuglevel 4 --prefix $IDADIR

    # Crack
    cp ${ida91-bit}/ida91/kg_patch/linux/* $IDADIR

    cp ${ida91-bit}/ida91/kg_patch/idapro.hexlic $IDADIR/
    cp ${ida91-bit}/ida91/kg_patch/idapro.hexlic $IDADIR/../

    # WDF Plugin
    cp ${srcWdfPlugin}/wdf_til/* $IDADIR/til/
    cp ${srcWdfPlugin}/wdf_plugin/* $IDADIR/plugins/
    cp ${srcWdfPlugin}/utils/* $IDADIR/

    # Link the exported libraries to the output.
    for lib in $IDADIR/libida*; do
      ln -s $lib $out/lib/$(basename $lib)
    done

    # Manually patch libraries that dlopen stuff.
    patchelf --add-needed libpython3.13.so $out/lib/libida.so
    patchelf --add-needed libcrypto.so $out/lib/libida.so

    # Some libraries come with the installer.
    addAutoPatchelfSearchPath $IDADIR

    # Link the binaries to the output.
    # Also, hack the PATH so that pythonForIDA is used over the system python.
    for bb in ida assistant; do
      wrapProgram $IDADIR/$bb \
        --prefix QT_PLUGIN_PATH : $IDADIR/plugins/platforms \
        --prefix PYTHONPATH : $out/opt/idalib/python \
        --prefix PATH : ${pythonForIDA}/bin
      ln -s $IDADIR/$bb $out/bin/$bb
    done

    runHook postInstall
  '';

  desktopIcon = makeDesktopIcon {
    name = "idapro";

    src = fetchurl {
      url = "https://static.wikitide.net/zenithwiki/0/0d/IDAIcon.png";
      sha256 = "sha256-9cCUkt7WD9gUurm4d43nGM4A8IRCKDv5TiWLFaUvvrs=";
    };
  };

  meta = with lib; {
    description = "The world's smartest and most feature-full disassembler";
    homepage = "https://hex-rays.com/ida-pro/";
    license = licenses.unfree;
    mainProgram = "ida";
    platforms = [ "x86_64-linux" ]; # Right now, the installation script only supports Linux.
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
