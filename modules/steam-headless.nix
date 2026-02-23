# steam-headless.nix
{ pkgs, ... }: {
  
  # Permite que o serviço rode em background para o seu usuário
  users.users.tux.linger = true;
  services.seatd.enable = true;

  systemd.user.services.steam-headless = {
    description = "Steam Gamescope Headless via SSH";

    unitConfig = {
      Conflicts = [ "display-manager.service" ];
    };
    
    # Garante que o SDDM não esteja rodando para não dar conflito de GPU
    # (Opcional, mas recomendado)
    
    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";

      ExecStart = ''
        ${pkgs.gamescope}/bin/gamescope \
          -W 1920 -H 1080 -r 60 --framerate-limit 60 \
          --backend headless \
          -- \
          ${pkgs.steam}/bin/steam -gamepadui -steamos -no-browser -forcedesktopscaling 1.0
      '';
      Restart = "on-failure";
      RestartSec = "5s";
    };

    environment = {
      "XDG_RUNTIME_DIR" = "/run/user/1000";
      "WLR_BACKENDS" = "headless";
      "WLR_LIBINPUT_NO_DEVICES" = "1";
      "SDL_VIDEODRIVER" = "x11";
      # MUDANÇA AQUI: Forçar o Gamescope a NÃO tentar ser um "mestre" de DRM
      "DISPLAY" = ":0";
      "WLR_RENDER_DRM_DEVICE" = "/dev/dri/renderD128";

      # Força o XWayland a usar um tamanho fixo de pixel
      "XCURSOR_SIZE" = "24"; 
      "XCURSOR_THEME" = "Adwaita";
      
      # Isso aqui é o "pulo do gato": 
      # Impede que a Steam detecte o monitor virtual como uma tela 4K
      "STEAM_FORCE_DESKTOPUI_SCALING" = "1.0";
    };
  };
}