{ pkgs, username, wallpaperDir, wallpaperGit }:

pkgs.writeShellScriptBin "wallpaper" ''
  monitor=(`hyprctl monitors | grep Monitor | awk '{print $2}'`)
  wal=$(find ${wallpaperDir} -name '*' | awk '!/.git/' | tail -n +2 | shuf -n 1)
  cache=""

  if [ -d ${wallpaperDir} ]; then
    cd ${wallpaperDir}
    git pull
  else
    ${pkgs.git}/bin/git clone ${wallpaperGit} ${wallpaperDir}
    chown -R ${username}:users ${wallpaperDir}
  fi

#  while true; do
    if [[ $cache == $wal ]]; then
      wal=$(find ${wallpaperDir} -name '*' | awk '!/.git/' | tail -n +2 | shuf -n 1)
    else
      cache=$wal
      hyprctl hyprpaper unload all
      hyprctl hyprpaper preload $wal
      for m in ''${monitor[@]}; do
        hyprctl hyprpaper wallpaper "$m,$wal"
      done
    fi
#    sleep 900
# done
''
