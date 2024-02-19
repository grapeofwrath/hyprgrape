{
  lib,
  grape-neovim,
  nixpkgs-stable,
  ...
}: let
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    neovim = chris-neovim.packages.${prev.system}.default;

    # nest a stable `nixpkgs` release inside of unstable
    nixpkgs-stable = nixpkgs-stable.legacyPackages.${prev.system};
  };
in
  lib.composeManyExtensions [additions modifications]
