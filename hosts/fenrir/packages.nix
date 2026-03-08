{ pkgs, ... }:

{
  programs.firefox.enable = false;
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  services.flatpak.enable = false;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.zenpower
    kdePackages.plasma-workspace
    kdePackages.kdeconnect-kde
    kdePackages.libkscreen
    kdePackages.bluedevil
    kdePackages.ktorrent
    kdePackages.bluez-qt
    kdePackages.kcalc
    v4l-utils
    gamescope
    sunshine
    ffmpeg
    sshfs
    lact
  ];
}
