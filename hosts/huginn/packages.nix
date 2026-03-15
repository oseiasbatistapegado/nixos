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
    ripgrep
    fd
    gnumake
    lua-language-server
  ];

  programs.fish.enable = true;
}
