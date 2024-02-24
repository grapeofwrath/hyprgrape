{ pkgs, wallpaperDir, wallpaperGit }:

pkgs.writeShellScriptBin "wallpaper" ''
  monitor=(`hyprctl monitors | grep Monitor | awk '{print $2}'`)
  wal=$(find ${wallpaperDir} -name '*' | awk '!/.git/' | tail -n +2 | shuf -n 1)
#  cache=""

  if [ -d ${wallpaperDir} ]; then
    cd ${wallpaperDir}
    git pull
  else
    ${pkgs.git}/bin/git clone ${wallpaperGit} ${wallpaperDir}
    chown -R marcus:users ${wallpaperDir}
  fi

  while true; do
    for m in ''${monitor[@]}; do
#      if [[ $cache == $wal ]]; then
        wal=$(find ${wallpaperDir} -name '*' | awk '!/.git/' | tail -n +2 | shuf -n 1)
#      else
#        cache=$wal
        ${pkgs.swww}/bin/swww img -o $m $wal
#      fi
#      sleep 1
    done
    sleep 900
 done
''
