{ pkgs, ... }:

{
  home.username = "tux";
  home.homeDirectory = "/home/tux";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    retroarch
    mangohud
    goverlay
    shadps4
    ppsspp
    pcsx2
    rpcs3
  ];
}
