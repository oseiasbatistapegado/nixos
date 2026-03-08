{ ... }:

{
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  networking.hosts = {
    "127.0.0.1" = [ "paradise-s1.battleye.com" "test-s1.battleye.com" "paradiseenhanced-s1.battleye.com" ];
  };
}
