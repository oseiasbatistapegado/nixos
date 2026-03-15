{ pkgs, unstable, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    unstable.code-cursor
    wl-clipboard
    moonlight-qt
    fastfetch
    otpclient
    swappy
    brave
    slurp
    grim
  ];
}
