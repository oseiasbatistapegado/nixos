{ ... }:

{
  hardware.graphics.enable32Bit = true;
  hardware.graphics.enable = true;

  services.xserver.enable = false;

  programs.xwayland.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;
  security.pam.services.sddm.enableKwallet = true;
}
