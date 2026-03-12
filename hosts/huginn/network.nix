{ ... }:
{
  networking.firewall = {
    enable = true;
    # Porta padrão do remote-touchpad
    allowedTCPPorts = [ 38731 ];
  };
}
