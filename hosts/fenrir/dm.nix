{ pkgs, ... }:

{
  hardware.graphics.enable32Bit = true;
  hardware.graphics.enable = true;
  hardware.enableRedistributableFirmware = true;

  services.xserver.enable = false;
  services.xserver.videoDrivers = [ "amdgpu" ];

  programs.xwayland.enable = true;

  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "tux";
    };
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  };

  services.desktopManager.plasma6.enable = true;
  security.pam.services.sddm.enableKwallet = true;
}
