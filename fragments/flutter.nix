{ pkgs, ... }:
let
  buildToolsVersion = "34.0.0";

  # We need an explicit Android composition so flutter can find the Android SDK
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [ buildToolsVersion "28.0.3" ];
    cmdLineToolsVersion = "13.0";
    platformVersions = [ "34" "28" ];
    abiVersions = [ "armeabi-v7a" "arm64-v8a" ];
  };

  androidSdk = androidComposition.androidsdk;
in {

  environment.systemPackages = with pkgs; [ flutter androidSdk ];

  environment.sessionVariables = {
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    NIXPKGS_ACCEPT_ANDROID_SDK_LICENSE = "1";
  };
}