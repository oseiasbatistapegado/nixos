{ ... }:

{
  security.doas.enable = true;
  security.doas.extraRules = [{
    users = [ "tux" ];
    keepEnv = true;  # Mantém variáveis de ambiente (importante para o seu KUBECONFIG!)
    persist = true;  # Não pede senha de novo por um tempo (estilo o timeout do sudo)
  }];
  security.sudo.enable = false;

  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  networking.hosts = {
    "127.0.0.1" = [ "paradise-s1.battleye.com" "test-s1.battleye.com" "paradiseenhanced-s1.battleye.com" ];
  };
}
