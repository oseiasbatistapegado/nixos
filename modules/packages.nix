{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.fuse.userAllowOther = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];
}
