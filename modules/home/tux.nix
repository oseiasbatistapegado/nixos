{ pkgs, unstable, ... }:

{
  home.username = "tux";
  home.homeDirectory = "/home/tux";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    telegram-desktop
    # code-server
    unstable.code-cursor
    easyeffects
    otpclient
    retroarch
    mangohud
    goverlay
    discord
    shadps4
    ppsspp
    pcsx2
    rpcs3
    brave
    git
    gh
  ];
}
