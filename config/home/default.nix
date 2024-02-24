{ pkgs, config, ... }:

{
  imports = [
    # Enable &/ Configure Programs
    ./style2-waybar.nix
    ./swaync.nix
    ./swaylock.nix
    ./starship.nix
    ./hyprland.nix
    ./kitty.nix
    ./rofi.nix
    ./bash.nix
    ./nushell.nix
    ./gtk-qt.nix

    # Install Programs & Scripts For User
    ./packages.nix

    # Place Home Files Like Pictures
    ./files.nix
  ];
}
