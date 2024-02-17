{ pkgs, config, browser, wallpaperDir, flakeDir,
  username, wallpaperGit, ... }:

{
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}" gh gnome.nautilus (pkgs.discord.override { withVencord = true; }) vesktop libvirt swww hyprpaper grim slurp gnome.file-roller
    swaynotificationcenter rofi-wayland imv transmission-gtk mpv
    gimp obs-studio blender-hip kdenlive godot_4 rustup audacity
    font-awesome spotify swayidle vim neovide neovim pavucontrol
    element-desktop swaylock-effects (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    inkscape filezilla
    # Import Scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallpaper.nix { inherit pkgs; inherit wallpaperDir;
      inherit username; inherit wallpaperGit; })
    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    (import ./../scripts/theme-selector.nix { inherit pkgs; })
    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
  ];
}
