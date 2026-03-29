{ pkgs, ... }:

let
  batteryControl = pkgs.writeShellScriptBin "huginn-battery-sync" ''
    PATH=$PATH:${pkgs.coreutils}/bin:${pkgs.gnugrep}/bin:${pkgs.gawk}/bin:${pkgs.fw-ectool}/bin
    
    sleep 2

    while true; do
      LEVEL=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "0")
      STATUS=$(ectool chargecontrol | grep "Charge mode" | awk '{print $4}')

      if [ "$LEVEL" -gt 5 ]; then
        if [ "$LEVEL" -ge 40 ] && [ "$STATUS" != "IDLE" ]; then
          ectool chargecontrol idle
          echo "Histerese: $LEVEL% atingido. Comando IDLE enviado."
        elif [ "$LEVEL" -le 30 ] && [ "$STATUS" == "IDLE" ]; then
          ectool chargecontrol normal
          echo "Histerese: $LEVEL% detectado. Comando NORMAL enviado."
        fi
      fi
      
      sleep 60
    done
  '';
in {
  # Movido de systemd.user para systemd.services (Sistema)
  systemd.services.huginn-battery-daemon = {
    description = "Monitor de Histerese da Bateria do Huginn (Root)";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${batteryControl}/bin/huginn-battery-sync";
      Restart = "always";
      RestartSec = 5;
    };
  };

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
      HWP_Mode: True
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
