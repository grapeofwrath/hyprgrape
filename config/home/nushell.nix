{ config, pkgs, flakeDir, ... }:

{
programs = {
    nushell = { enable = true;
      extraConfig = ''
       let carapace_completer = {|spans|
       carapace $spans.0 nushell $spans | from json
       }
       $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true
        # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100
            completer: $carapace_completer # check 'carapace_completer'
          }
        }
       }
       $env.PATH = ($env.PATH |
       split row (char esep) |
       prepend /home/myuser/.apps |
       append /usr/bin/env
       )
       '';
      shellAliases = {
        sv="sudo nvim";
        rebuild="sudo nixos-rebuild switch --flake ${flakeDir}";
        update="sudo nix flake update ${flakeDir}";
        gcCleanup="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
        v="nvim";
        #ls="lsd";
        #ll="lsd -l";
        #la="lsd -a";
        #lal="lsd -al";
        ".."="cd ..";
        #nvim="nix run github:grapeofwrath/nixvim-flake";
        nvim="nix run ~/nixvim-flake --";
      };
   };
   carapace.enable = true;
   carapace.enableNushellIntegration = true;
  };
}
