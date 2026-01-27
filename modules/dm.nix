{ ... }:

{
  hardware.graphics.enable32Bit = true;
  hardware.graphics.enable = true;

  services.xserver.enable = false;

  programs.xwayland.enable = true;

  services.displayManager.sddm.wayland.enable = true;
  services.displayManager = {
    enable = true;

    autoLogin = {
      enable = true;
      user = "tux";
    };
  };

  services.desktopManager.plasma6.enable = true;
  security.pam.services.sddm.enableKwallet = true;
}