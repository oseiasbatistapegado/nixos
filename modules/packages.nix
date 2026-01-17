{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = false;
  programs.steam.enable = true;

  services.flatpak.enable = false;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.zenpower
    neovim
    kdePackages.bluedevil
    kdePackages.bluez-qt
    kdePackages.plasma-workspace
    kdePackages.ktorrent
  ];
}