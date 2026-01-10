{ pkgs, ... }:

{
  home.username = "tux";
  home.homeDirectory = "/home/tux";

  services.flatpak = {
    enable = true;
    packages = [
      "com.valvesoftware.Steam"
      "com.discordapp.Discord"
      "com.brave.Browser"
      "org.telegram.desktop"
      "org.libretro.RetroArch"
      "org.ppsspp.PPSSPP"
      "net.pcsx2.PCSX2"
      "net.rpcs3.RPCS3"
      "net.shadps4.shadPS4"
      "com.stremio.Stremio"
      "org.gnome.Boxes"
      "com.getpostman.Postman"
      "io.dbeaver.DBeaverCommunity"
      "io.github.benjamimgois.goverlay"
      "org.kde.ktorrent"
      "net.audiorelay.AudioRelay"
    ];
  };

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