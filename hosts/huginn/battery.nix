{ pkgs, ... }:

let
  batteryControl = pkgs.writeShellScriptBin "huginn-battery-sync" ''
    # Adicionamos o diretório dos wrappers do NixOS para o sudo funcionar
    PATH=$PATH:${pkgs.coreutils}/bin:${pkgs.gnugrep}/bin:${pkgs.gawk}/bin:/run/wrappers/bin
    
    sleep 2

    while true; do
      LEVEL=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "0")
      
      # Usamos o caminho absoluto do wrapper do sudo
      STATUS=$(sudo ${pkgs.fw-ectool}/bin/ectool chargecontrol | grep "Charge mode" | awk '{print $4}')

      if [ "$LEVEL" -gt 5 ]; then
        if [ "$LEVEL" -ge 40 ] && [ "$STATUS" != "IDLE" ]; then
          sudo ${pkgs.fw-ectool}/bin/ectool chargecontrol idle
          echo "Histerese: $LEVEL% atingido. Comando IDLE enviado."
        elif [ "$LEVEL" -le 30 ] && [ "$STATUS" == "IDLE" ]; then
          sudo ${pkgs.fw-ectool}/bin/ectool chargecontrol normal
          echo "Histerese: $LEVEL% detectado. Comando NORMAL enviado."
        fi
      fi
      
      sleep 60
    done
  '';
in {
  systemd.user.services.huginn-battery-daemon = {
    description = "Monitor de Histerese da Bateria do Huginn (Sessão de Usuário)";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${batteryControl}/bin/huginn-battery-sync";
      Restart = "always";
      RestartSec = 5;
    };
  };

  security.sudo.extraRules = [{
    users = [ "tux" ];
    commands = [{
      command = "${pkgs.fw-ectool}/bin/ectool";
      options = [ "NOPASSWD" ];
    }];
  }];
  powerManagement.cpuFreqGovernor = "performance";
  services.throttled = {
    enable = true;
    extraConfig = ''
      [GENERAL]
      Enabled: True
      Sysfs_Power_Path: /sys/class/power_supply/AC/online

      [BATTERY]
      Update_Rate_s: 30
      PL1_Tdp_W: 10
      PL2_Tdp_W: 15
      Trip_Temp_C: 85
      # HWP_Mode aqui é um booleano (True ativa o gerenciamento)
      HWP_Mode: True
      # EPP é onde você define a agressividade
      EPP_Preference_Battery: balance_performance

      [AC]
      Update_Rate_s: 5
      PL1_Tdp_W: 15
      PL2_Tdp_W: 20
      Trip_Temp_C: 90
      HWP_Mode: True
      EPP_Preference_AC: performance
    '';
    };
}
