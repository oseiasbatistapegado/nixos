{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = false;

  services.flatpak.enable = false;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.zenpower
  ];
}