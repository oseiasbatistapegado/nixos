{ pkgs, unstable, ... }:

{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [];
}
