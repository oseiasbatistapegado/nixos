{ pkgs, ... }:

{
  home.username = "tux";
  home.homeDirectory = "/home/tux";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    mangohud
    neovim
    gh
    podman
    kdePackages.bluedevil
    kdePackages.bluez-qt
    kdePackages.plasma-workspace
    kdePackages.ktorrent

    steam
    discord
    brave
    telegram-desktop
    retroarch
    ppsspp
    pcsx2
    rpcs3
    shadps4
    stremio
    postman
    dbeaver-bin
    goverlay
  ];

  programs.git.enable = true;
}