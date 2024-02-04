{ config, pkgs, inputs, username,
  gitUsername, gitEmail, gtkThemeFromScheme,
  theme, browser, wallpaperDir, wallpaperGit,
  flakeDir, waybarStyle, ... }:

{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # Set The Colorscheme
  colorScheme = inputs.nix-colors.colorSchemes."${theme}";

  # Import Program Configurations
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    ./config/home
  ];

  # Define Settings For Xresources
  xresources.properties = {
    "Xcursor.size" = 24;
  };

  # Install & Configure Git
  #home.file.".ssh/allowed_signers".text =
  #  "* ${builtins.readFile /home/${username}/.ssh/id_ed25519.pub}";

  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
    #extraConfig = {
        # Sign all commits using ssh key
        #commit.gpgsign = true;
        #gpg.format = "ssh";
        #gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        #user.signingkey = "~/.ssh/id_ed25519.pub";
  };

  # Create XDG Dirs
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
