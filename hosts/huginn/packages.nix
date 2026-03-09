{ pkgs, unstable, ... }:

{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
    blueman
    font-awesome
  ];
}
