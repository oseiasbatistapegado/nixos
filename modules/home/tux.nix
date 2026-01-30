{ pkgs, ... }:

{
  home.username = "tux";
  home.homeDirectory = "/home/tux";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    mangohud
    git
    code-cursor
    otpclient
    gh
    discord
    brave
    telegram-desktop
    retroarch
    ppsspp
    pcsx2
    rpcs3
    shadps4
    goverlay
  ];
}
