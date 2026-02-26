{ config, pkgs, ... }: {
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  # services.code-server = {
  #   enable = true;
  #   user = "tux";
  #   auth = "password";
  #   port = 8080;
  #   host = "0.0.0.0";
  # };

  # services.ollama = {
  #   enable = false;
  #   acceleration = "rocm"; # Força o uso do ROCm

  #   # Para a 7900 XTX, às vezes é necessário forçar a versão do ROCm
  #   # caso o Ollama não detecte automaticamente (RDNA 3 suporte)
  #   rocmOverrideGfx = "11.0.0";

  #   # Opcional: define onde os modelos pesados (32B) serão salvos
  #   home = "/media/games/ollama";
  #   host = "0.0.0.0";
  #   port = 11434;
  #   group = "users";
  # };
}