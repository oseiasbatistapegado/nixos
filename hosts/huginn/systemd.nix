{ pkgs, config, ... }:

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

  systemd.user.services.roc-receiver = {
    description = "ROC Receiver Service";
    after = [ "pipewire.service" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.roc-toolkit}/bin/roc-recv -vv -s rtp+rs8m://huginn.lan:10001 -r rs8m://huginn.lan:10002 -c rtcp://huginn.lan:10003";
      Restart = "always";
      RestartSec = "5";
    };
  };

  systemd.user.services."roc-transmitter@" = {
    description = "ROC Transmitter para o IP %i";
    after = [ "pipewire.service" ];
    
    serviceConfig = {
      ExecStart = "${pkgs.roc-toolkit}/bin/roc-send -vv -i pulse://default -s rtp+rs8m://%i:10001 -r rs8m://%i:10002 -c rtcp://%i:10003";
      Restart = "always";
      RestartSec = "5";
    };
  };

  services.resolved.enable = false;
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    settings = {
      http = {
        address = "127.0.0.1:3000";
      };
      dns = {
        bind_hosts = ["0.0.0.0"];
        port = 53;

        upstream_dns = [
          "1.1.1.1"
          "8.8.8.8"
          "https://dns.cloudflare.com/dns-query"
        ];
      };
      filtering = {
        filtering_enabled = true;
        rewrites = [
          { domain = "huginn.lan"; answer = "192.168.1.103"; enabled = true; }
          { domain = "fenrir.lan"; answer = "192.168.1.102"; enabled = true; }
          { domain = "mk_server.lan"; answer = "192.168.1.246"; enabled = true; }
          { domain = "router.lan"; answer = "192.168.1.1"; enabled = true; }
          { domain = "ze.lan"; answer = "192.168.1.154"; enabled = true; }
          { domain = "mobile.lan"; answer = "192.168.1.201"; enabled = true; }
          { domain = "mi.lan"; answer = "192.168.1.128"; enabled = true; }
        ];
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /tmp/.X11-unix 1777 root root -"
  ];
}
