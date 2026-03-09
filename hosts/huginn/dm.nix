{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver 
      libvdpau-va-gl
    ];
  };
  hardware.enableRedistributableFirmware = true;

  services.xserver.enable = false;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.xwayland.enable = true;

  services.displayManager = {
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
