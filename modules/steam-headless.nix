# steam-headless.nix
{ pkgs, ... }: {
  
  # Permite que o serviço rode em background para o seu usuário
  users.users.tux.linger = true;

  systemd.user.services.steam-headless = {
    description = "Steam Gamescope Headless via SSH";

    unitConfig = {
      Conflicts = [ "sddm.service" ];
    };
    
    # Garante que o SDDM não esteja rodando para não dar conflito de GPU
    # (Opcional, mas recomendado)
    
    serviceConfig = {
      ExecStart = ''
        ${pkgs.gamescope}/bin/gamescope \
          -W 1920 -H 1080 -r 60 -f 60 \
          --headless \
          -- \
          ${pkgs.steam}/bin/steam -gamepadui -steamos
      '';
      Restart = "on-failure";
    };

    environment = {
      "XDG_RUNTIME_DIR" = "/run/user/1000";
      "WLR_LIBINPUT_NO_DEVICES" = "1";
      "WLR_BACKENDS" = "headless";
      "SDL_VIDEODRIVER" = "wayland";
    };
  };
}