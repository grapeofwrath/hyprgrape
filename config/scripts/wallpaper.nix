{ pkgs, username, wallpaperDir, wallpaperGit }:

pkgs.writeShellScriptBin "wallpaper" ''
  hyprpaper=hyprctl hyprpaper
  timeout=900
  monitor=(`hyprctl monitors | grep Monitor | awk '{print $2}'`)
  wal=$(find ${wallpaperDir} -name '*' | awk '!/.git/' | tail -n +2 | shuf -n 1)
  cache=/home/${username}/.config/hypr/cache-wal.conf

  if [ -d ${wallpaperDir} ]; then
    cd ${wallpaperDir}
    git pull
  else
    ${pkgs.git}/bin/git clone ${wallpaperGit} ${wallpaperDir}
    chown -R ${username}:users ${wallpaperDir}
  fi

  $hyprpaper unload all
  echo "" > "$cache"

  #for m in ''${monitor[@]}; do
  #  while true;
  #  do
  #    if [ grep -Fq $wal $cache ]
  #    then
  #      wal=$(find ${wallpaperDir} -name '*' | awk '!/.git/' | tail -n +2 | shuf -n 1)
  #    else
  #      #esac
  #      $hyprpaper preload $wal
  #      $hyprpaper wallpaper "$m,$wal"
  #      echo "preload = $wal" >> "$cache"
  #      echo "wallpaper = $m,$wal" >> "$cache"
  #      sleep $timeout
  #    fi
  #  done
  #done

  for m in {monitor[@]}; do
    wal=$(find ${wallpaperDir} -name '*' | awk '!/.git/' | tail -n +2 | shuf -n 1)
    $hyprpaper preload $wal
    $hyprpaper wallpaper "$m,$wal"
    #echo "preload = $wal" >> "$cache"
    #echo "wallpaper = $m,$wal" >> "$cache"
  done
''
