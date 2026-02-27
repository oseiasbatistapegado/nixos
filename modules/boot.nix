{ config, ... }:

{
  boot.extraModulePackages = [ config.boot.kernelPackages.zenpower config.boot.kernelPackages.v4l2loopback ];
  boot.kernelParams = [ "pcie_aspm=force" "amdgpu.ppfeaturemask=0xffffffff" "amdgpu.sg_display=0" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="Webcam-Remota" exclusive_caps=1
  '';
  boot.kernelModules = [ "zenpower" "v4l2loopback" ];
  boot.blacklistedKernelModules = [ "k10temp" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
}