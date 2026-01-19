{ pkgs, ... }:

{
  home.username = "tux";
  home.homeDirectory = "/home/tux";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    mangohud
    git
    vscode
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

  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "NvChad";
    rev = "6a0715d3f30eca1732ac2120ca5215925b2406c9";
    sha256 = "sha256-1bdNuC79Kc9hDIX569WFl3E5XRxklE2b013wTZjrmt4=";
  };
}