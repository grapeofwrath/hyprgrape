{ pkgs, config, ... }:

{
  home.file.".config/swaylock/config".text = ''
    indicator-caps-lock
    show-failed-attempts
    ignore-empty-password
    indicator-thickness=15
    indicator-radius=150
    # image=~/Pictures/Wallpapers/dhc-2-beaver.jpg
    screenshots
    effect-pixelate=10
    fade-in=0.5
    ring-color=${config.colorScheme.colors.base0D}
    key-hl-color=${config.colorScheme.colors.base0F}
    line-color=00000000
    inside-color=00000088
    inside-clear-color=00000088
    separator-color=00000000
    text-color=${config.colorScheme.colors.base05}
    text-clear-color=${config.colorScheme.colors.base05}
    ring-clear-color=${config.colorScheme.colors.base0D}
    font=Ubuntu
  '';
}
