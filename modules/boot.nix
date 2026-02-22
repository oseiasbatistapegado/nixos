{ config, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = [ "k10temp" ];
  boot.kernelModules = [ "zenpower" ];
  boot.kernelParams = [ "pcie_aspm=force" "amdgpu.ppfeaturemask=0xffffffff" "amdgpu.sg_display=0" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.zenpower ];
}