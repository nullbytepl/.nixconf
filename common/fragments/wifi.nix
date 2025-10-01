{ ... }:
{
    # This violates some laws but I want Wifi 6
    boot.extraModprobeConfig = ''
        options cfg80211 ieee80211_regdom="US"
    '';
}
