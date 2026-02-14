{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.fuse.userAllowOther = true;
  programs.firefox.enable = false;
  programs.steam.enable = true;

  services.flatpak.enable = false;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.zenpower
    kdePackages.bluedevil
    kdePackages.bluez-qt
    kdePackages.plasma-workspace
    kdePackages.kcalc
    kdePackages.ktorrent
    kdePackages.kdeconnect-kde
    neovim
    sshfs
    lact
  ];
}
