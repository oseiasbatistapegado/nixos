{ pkgs, unstable, ... }:
{
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
