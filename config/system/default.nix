{ config, pkgs, ... }:

{
  imports = [
    ./amd-gpu.nix
    ./boot.nix
    ./displaymanager.nix
    ./intel-amd.nix
    ./intel-gpu.nix
    ./intel-nvidia.nix
    ./nvidia.nix
    ./packages.nix
    ./polkit.nix
    ./services.nix
    ./steam.nix
  ];
}
