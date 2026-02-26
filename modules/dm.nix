{ ... }:

{
  hardware.graphics.enable32Bit = true;
  hardware.graphics.enable = true;
  hardware.enableRedistributableFirmware = true;

  services.xserver.enable = false;
  services.xserver.videoDrivers = [ "amdgpu" ];

  programs.xwayland.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;
  security.pam.services.sddm.enableKwallet = true;
}
