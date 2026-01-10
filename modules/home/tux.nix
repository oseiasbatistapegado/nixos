{ pkgs, ... }:

{
  home.username = "tux";
  home.homeDirectory = "/home/tux";

  home.packages = with pkgs; [
    mangohud
    neovim
    gh
    podman
    kdePackages.bluedevil
    kdePackages.bluez-qt
    kdePackages.plasma-workspace
  ];

  programs.git.enable = true;
}