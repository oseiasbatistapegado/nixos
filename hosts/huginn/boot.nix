{ ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.kernelModules = [ "uinput" ];
  boot.tmp.useTmpfs = true;

boot.kernel.sysctl = {
    # Foco em manter o sistema responsivo durante escritas em disco
    "vm.dirty_bytes" = 50331648;          # 48MB
    "vm.dirty_background_bytes" = 25165824; # 24MB
    
    # Pressão agressiva para liberar cache e manter apps na RAM
    "vm.vfs_cache_pressure" = 200;
    
    # Swappiness alto para usar o LZO-RLE o quanto antes
    "vm.swappiness" = 180;
    
    # Otimização para zRAM: processar uma página por vez evita picos de latência
    "vm.page-cluster" = 0;

    # Reserva de emergência aumentada (essencial já que você está sem swapfile)
    # Garante que o Kernel/Driver de Vídeo tenha ~100MB intocáveis
    "vm.min_free_kbytes" = 102400; 
  };

  boot.kernelParams = [ 
    "video=eDP-1:d"
    "video=DP-1:1920x1080@60"
    "scsi_mod.use_blk_mq=1"
    "elevator=mq-deadline" # Melhor para eMMC/SD Cards
    "zswap.enabled=0"      # Desativa o zswap para não conflitar com seu zram
  ];
}
