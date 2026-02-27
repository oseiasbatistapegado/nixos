{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.fuse.userAllowOther = true;
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
    # rocmPackages.rocminfo
    kdePackages.bluedevil
    # rocmPackages.rocm-smi
    kdePackages.ktorrent
    kdePackages.bluez-qt
    kdePackages.kcalc
    v4l-utils
    gamescope
    neovim
    ffmpeg
    sshfs
    lact
  ];
}
