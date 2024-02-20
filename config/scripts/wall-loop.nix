{ pkgs, ... }:

pkgs.writeShellScriptBin "wall-loop" ''
  while true; do
    wallpaper
    sleep 5
 done
''
