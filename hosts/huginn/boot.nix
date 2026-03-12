{ ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.kernelModules = [ "uinput" ];

  boot.kernelParams = [ 
    "video=eDP-1:d"                # 'd' de disable (desativa a tela do Chromebook no boot)
    "video=DP-1:1920x1080@60"      # Força 1080p no monitor externo (ajuste se for outra)
    "uinput"
  ];
}
