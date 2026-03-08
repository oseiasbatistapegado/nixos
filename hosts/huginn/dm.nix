{ pkgs, ... }:

{
  hardware.graphics.enable = true;
  hardware.enableRedistributableFirmware = true;

  services.xserver.enable = false;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.xwayland.enable = true;

  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "tux";
    };
    defaultSession = "hyprland";
    ly = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}
