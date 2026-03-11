{ pkgs, unstable, ... }:

{
  programs.firefox.enable = false;
  programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
    blueman
  ];
}
