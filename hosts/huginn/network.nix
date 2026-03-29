{ config, ... }:
{
  networking.nameservers = [ "127.0.0.1" ];
  networking.networkmanager.dns = "none";
  networking.dhcpcd.extraConfig = "nohook resolv.conf";
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [
      config.services.tailscale.port
      53
      10001
      10002
      10003
    ];
    # Porta padrão do remote-touchpad
    allowedTCPPorts = [ 38731 53 ];
  };
}
