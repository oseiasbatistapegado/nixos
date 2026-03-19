{ ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.kernelModules = [ "uinput" ];
  boot.tmp.useTmpfs = true;

  boot.kernel.sysctl = {
    "vm.dirty_bytes" = 50331648;        # 48MB - Força gravar no USB mais cedo em blocos menores
    "vm.dirty_background_bytes" = 25165824; # 24MB
  };

  boot.kernelParams = [ 
    "video=eDP-1:d"                # 'd' de disable (desativa a tela do Chromebook no boot)
    "video=DP-1:1920x1080@60"      # Força 1080p no monitor externo (ajuste se for outra)
    "scsi_mod.use_blk_mq=1"
    "uinput"
  ];
}
