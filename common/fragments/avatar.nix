{ config, pkgs, ... }: {
  system.activationScripts.script.text = ''
    for user in /home/*; do
      src="$user/.face.icon"
      dst="/var/lib/AccountsService/icons/$(basename $user)"

      if [ -e "$src" ]; then
        if [ ! -e "$dst" ] || [ ! "$src" -ef "$dst" ]; then
          cp -L "$src" "$dst"
        fi
      fi
    done
  '';
}
