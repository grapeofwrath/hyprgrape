{ pkgs, config, wallpaperDir, flakeDir,
  wallpaperGit, ... }:

{
  # Install Packages For The User
  home.packages = with pkgs; [
    brave gh gnome.nautilus libvirt grim slurp gnome.file-roller
    swaynotificationcenter rofi-wayland imv transmission-gtk mpv
    gimp obs-studio blender-hip kdenlive godot_4 rustup audacity
    font-awesome spotify swayidle vim neovide neovim pavucontrol
    element-desktop swaylock-effects (nerdfonts.override { fonts = [ "JetBrainsMono" "CascadiaCode" ]; })
    inkscape filezilla (pkgs.discord.override { withVencord = true; }) vesktop
    lazygit swww fzf zoxide direnv
    # Import Scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallpaper.nix { inherit pkgs; inherit wallpaperDir;
      inherit wallpaperGit; })
    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
  ];
}
