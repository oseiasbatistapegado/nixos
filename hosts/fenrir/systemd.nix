{ pkgs, ... }:

{
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  systemd.user.services.create-virtual-monitor = {
    description = "Cria monitor virtual para o Sunshine";
    wantedBy = [ "plasma-kwin_wayland.service" ];
    after = [ "plasma-kwin_wayland.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.dbus}/bin/dbus-send --session --print-reply --dest=org.kde.KWin \
        /KWin org.kde.KWin.createVirtualOutput string "Headless-1" int32 1920 int32 1080 double 1.0
      '';
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  systemd.user.services.sunshine = {
    description = "Sunshine Streaming Server";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "/run/wrappers/bin/sunshine";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 3";
      Restart = "always";
      RestartSec = "5s";
    };
  };
}
