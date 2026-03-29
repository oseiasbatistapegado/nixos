{ pkgs, unstable, ... }:

{
  programs.firefox.enable = false;
  programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs; [
    (remote-touchpad.override {
      buildGoModule = args: pkgs.buildGoModule (args // {
        tags = [ "uinput" ];
      });
    })
    pavucontrol
    blueman
    fish
    sshfs
    gcc
    waypipe
    ripgrep
    fd
    gnumake
    lua-language-server
    fw-ectool
    roc-toolkit
  ];

  programs.fish.enable = true;
}
