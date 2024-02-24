{ pkgs, config, cpuType, gpuType, inputs, lib, ... }:

let
  theme = config.colorScheme.colors;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
    ];
    extraConfig = lib.concatStrings [ ''
      ${if cpuType == "vm" then ''
        env = WLR_NO_HARDWARE_CURSORS,1
        env = WLR_RENDERER_ALLOW_SOFTWARE,1
      '' else ''
      ''}
      ${if gpuType == "nvidia" then ''
        env = WLR_NO_HARDWARE_CURSORS,1
      '' else ''
      ''}
    ''
    ];
    settings = {
      monitor = [
        "HDMI-A-1,1920x1080@60,1920x0,1"
        "DP-1,1920x1080@165,0x0,1"
        ",preferred,auto,1"
      ];
      general = {
        gaps_in = "6";
        gaps_out = "8";
        border_size = "2";
        #col = {
        #  active_border = "rgba(${theme.base0C}ff) rgba(${theme.base0D}ff) rgba(${theme.base0B}ff) rgba(${theme.base0E}ff) 45deg";
        #  inactive_border = "rgba(${theme.base00}cc) rgba(${theme.base01}cc) 45deg";
        #};
        layout = "dwindle";
        resize_on_border = true;
      };
      input = {
        kb_layout = "us";
        kb_options="caps:super";
        follow_mouse = "1";
        sensitivity = "0";
        accel_profile = "flat";
      };
      env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland"
        "CLUTTER_BACKEND, wayland"
        "SDL_VIDEODRIVER, wayland"
        "XCURSOR_SIZE, 24"
        "XCURSOR_THEME, Bibata-Modern-Ice"
        "QT_QPA_PLATFORM, wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "MOZ_ENABLE_WAYLAND, 1"
      ];
      misc = {
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = false;
       force_default_wallpaper = "0";
       disable_splash_rendering = true;
      };
      animations = {
        enabled = "yes";
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 90, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };
      decoration = {
        rounding = "10";
        drop_shadow = false;
        blur = {
          enabled = true;
          size = "5";
          passes = "3";
          new_optimizations = "on";
          ignore_opacity = "on";
        };
      };
      exec-once = [
        "$POLKIT_BIN"
        "dbus-update-activation-environment --systemd --all"
        "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprctl setcursor Bibata-Modern-Ice 24"
        "swww init"
        "waybar"
        "swaync"
        "wallpaper"
        "swayidle -w timeout 900 'swaylock -f'"
      ];
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_is_master = true;
      };
      "$mod" = "SUPER";
      bind = [
        "$mod,Return,exec,kitty"
        "$modSHIFT,Return,exec,rofi -show drun"
        "$modSHIFT,W,exec,kitty -e amfora"
        "$modSHIFT,S,exec,swaync-client -rs"
        "$mod,L,exec,swaylock -f"
        "$mod,W,exec,brave"
        "$mod,E,exec,brave --new-window mail.proton.me"
        "$mod,S,exec,grim -g '$(slurp)'"
        "$mod,D,exec,discord"
        "$mod,O,exec,obs"
        "$modSHIFT,G,exec,godot4"
        "$mod,T,exec,nautilus"
        "$mod,M,exec,ario"
        "$mod,Q,killactive,"
        "$mod,P,pseudo,"
        "$modSHIFT,I,togglesplit,"
        "$mod,F,fullscreen,"
        "$modSHIFT,F,togglefloating,"
        "$modSHIFT,C,exit,"
        "$modSHIFT,left,movewindow,l"
        "$modSHIFT,right,movewindow,r"
        "$modSHIFT,up,movewindow,u"
        "$modSHIFT,down,movewindow,d"
        "$modSHIFT,h,movewindow,l"
        "$modSHIFT,l,movewindow,r"
        "$modSHIFT,k,movewindow,u"
        "$modSHIFT,j,movewindow,d"
        "$mod,left,movefocus,l"
        "$mod,right,movefocus,r"
        "$mod,up,movefocus,u"
        "$mod,down,movefocus,d"
        "$mod,h,movefocus,l"
        "$mod,l,movefocus,r"
        "$mod,k,movefocus,u"
        "$mod,j,movefocus,d"
        "$mod,mouse_down,workspace, e+1"
        "$mod,mouse_up,workspace, e-1"
        ",XF86AudioRaiseVolume,exec,wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ]
      ++ (
        builtins.concatLists (builtins.genList (
          x: let
            ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        10)
      );
      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];
    };
  };
}
