{ config, ... }:
{
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    # Porta padrão do remote-touchpad
    allowedTCPPorts = [ 38731 ];
  };
}
