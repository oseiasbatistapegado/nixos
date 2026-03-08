{ pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
  };

  services.flatpak.enable = false;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.zenpower
    kdePackages.plasma-workspace
    kdePackages.libkscreen
    kdePackages.bluedevil
    kdePackages.ktorrent
    kdePackages.bluez-qt
    kdePackages.kcalc
    sunshine
    sshfs
    lact
  ];
}
