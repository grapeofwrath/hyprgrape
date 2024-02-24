{ config, pkgs, inputs,
  gtkThemeFromScheme,
  wallpaperDir, wallpaperGit,
  flakeDir, ... }:

{
home.stateVersion = "23.11";
#  home = {
#    stateVersion = "23.11";
#    username = "marcus";
#    homeDirectory = "/home/marcus";
#    pointerCursor = {
#      gtk.enable = true;
#      x11.enable = true;
#      package = pkgs.bibata-cursors;
#      name = "Bibata-Modern-Ice";
#      size = 24;
#    };
#    file = {
#      ".config/zaney-stinger.mov".source = ./files/media/zaney-stinger.mov;
#      ".emoji".source = ./files/emoji;
#      #".base16-themes".source = ./files/base16-themes;
#      ".face.icon".source = ./files/face.jpg; # For SDDM
#      ".config/rofi/rofi.jpg".source = ./files/rofi.jpg;
#      ".local/share/fonts" = {
#        source = ./files/fonts;
#        recursive = true;
#      };
#    };
#    packages = [
#      pkgs.brave
#      pkgs.gh
#      pkgs.gnome.nautilus
#      pkgs.gnome.file-roller
#      pkgs.grim
#      pkgs.slurp
#      pkgs.swaynotificationcenter
#      pkgs.rofi-wayland
#      pkgs.imv
#      pkgs.transmission-gtk
#      pkgs.mpv
#      pkgs.gimp
#      pkgs.obs-studio
#      pkgs.kdenlive
#      pkgs.godot_4
#      pkgs.rustup
#      pkgs.audacity
#      pkgs.font-awesome
#      pkgs.spotify
#      pkgs.swayidle
#      pkgs.vim
#      pkgs.neovim
#      pkgs.pavucontrol
#      pkgs.element-desktop
#      pkgs.swaylock-effects
#      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
#      pkgs.inkscape
#      pkgs.filezilla
#      (pkgs.discord.override { withVencord = true; })
#      pkgs.vesktop
#      pkgs.lazygit
#      pkgs.swww
#      pkgs.fzf
#      pkgs.zoxide
#      pkgs.direnv
#    ];
#  };

  colorScheme = inputs.nix-colors.colorSchemes.rose-pine;

  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    ./config/home
  ];

  xresources.properties = {
    "Xcursor.size" = 24;
  };

  programs.git = {
    enable = true;
    userName = "grapeofwrath";
    userEmail = "69535018+grapeofwrath@users.noreply.github.com";
    package = pkgs.gitFull;
    extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
      push = { autoSetupRemote = true; };
    };
  };

  programs.fzf = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg = {
    userDirs = {
        enable = true;
        createDirectories = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.home-manager.enable = true;
}
