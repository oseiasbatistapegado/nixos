{ config, ... }:

{
  services.earlyoom.enable = true;
  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscale_key.path;
  };

  systemd.services.k3s = {
    after = [ "tailscaled.service" "network-online.target" ];
    wants = [ "tailscaled.service" ];
  };
  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = config.age.secrets.k3s_token.path;
    extraFlags = [
      "--disable traefik"
      "--disable" "servicelb"
      "--node-name huginn"
      "--node-taint CriticalAddonsOnly=true:NoSchedule"
      "--advertise-address 100.82.110.110"
      "--node-ip 100.82.110.110"
      "--node-external-ip 100.82.110.110"
      "--flannel-iface=tailscale0" # Força o tráfego interno dos pods pelo túnel
    ];
  };

  systemd.tmpfiles.rules = [
    "d /tmp/.X11-unix 1777 root root -"
  ];
}
