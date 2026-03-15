{ pkgs, ... }:

{
  imports = [
    ./utils.nix
  ];

  home.username = "tux";
  home.homeDirectory = "/home/tux";
  home.stateVersion = "25.11";
}

