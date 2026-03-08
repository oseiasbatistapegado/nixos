{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;

  services.printing.enable = false;

  services.openssh.enable = true;

  # Sunshine + Moonlight / KDE Connect firewall
  networking.firewall.allowedTCPPorts = [
    47984
    47989
    47990
    48010
  ];
  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; }
    { from = 47998; to = 48000; }
    { from = 48002; to = 48010; }
  ];

  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+ep";
    source = "${pkgs.sunshine}/bin/sunshine";
  };
}
