{ config, pkgs, ... }: {
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  services.code-server = {
    enable = true;
    user = "tux";
    auth = "password";
    port = 8080;
    host = "0.0.0.0";
  };
}