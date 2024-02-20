{ config, pkgs, flakeDir, ... }:

{
  # Configure Bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #  exec Hyprland
      #fi
      if command -v fzf-share >/dev/null; then
        source "$(fzf-share)/key-bindings.bash"
        source "$(fzf-share)/completion.bash"
      fi
      
      eval "$(zoxide init bash)"
    '';
    initExtra = ''
      if [ -f $HOME/.bashrc-personal ]; then
        source $HOME/.bashrc-personal
      fi
    '';
    sessionVariables = {
    
    };
    shellAliases = {
      sv="sudo nvim";
      rebuild="sudo nixos-rebuild switch --flake ${flakeDir}";
      update="sudo nix flake update ${flakeDir}";
      gcCleanup="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      v="nvim";
      ls="lsd";
      ll="lsd -l";
      la="lsd -a";
      lal="lsd -al";
      ".."="cd ..";
      #nvim="nix run github:grapeofwrath/nixvim-flake";
      nvim="nix run ~/nixvim-flake --";
    };
  };
}
