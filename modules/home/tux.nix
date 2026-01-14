{ pkgs, ... }:

{
  home.username = "tux";
  home.homeDirectory = "/home/tux";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    mangohud
    neovim
    git
    vscode
    gh
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
    goverlay
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      theme = "BreezeDark";
      iconTheme = "breeze-dark";
    };

    kwin = {
      effects = {
        blur.enable = true;
        translucency.enable = true;
      };
    };
  };
}