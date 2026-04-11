{ pkgs, unstable, agenix, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Oséias Batista Pegado";
        email = "oseias.batista.dev@gmail.com";
        signingkey = "~/.ssh/id_ed25519_personal.pub";
      };
      init.defaultBranch = "main";
      gpg.format = "ssh";
      "gpg \"ssh\"".allowedSignersFile = "~/.config/git/allowed_signers";
      commit.gpgsign = true;
      tag.gpgsign = true;
    };

    # includes = [
    #   {
    #     condition = "gitdir:~/Documents/mk/";
    #     contents = {
    #       user = {
    #         name = "OseiasMK";
    #         email = "oseias.batista@mksolutions.com.br";
    #       };
    #       core = {
    #         sshCommand = "ssh -i ~/.ssh/id_ed25519_mk";
    #       };
    #     };
    #   }
    # ];
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "github.com-personal" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_personal";
      };
      "codeberg.org" = {
        hostname = "codeberg.org";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_personal";
      };
      "github.com-mk" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_mk";
      };
      "fenrir" = {
        hostname = "fenrir.lan";
        user = "tux";
        identityFile = "~/.ssh/id_ed25519_fenrir";
      };
      "mk-server" = {
        hostname = "mk_server.lan";
        user = "mk";
        identityFile = "~/.ssh/id_ed25519_mk_server";
      };
    };
  };

  home.file.".local/share/posting/themes/rapture.yaml".text = ''
    name: rapture
    author: Oséias
    
    # Base do Sistema (Identidade Visual do seu Foot)
    background: '#111e2a'
    foreground: '#c0c9e5'
    
    # UI Elements: Trocando o rosa pelo azul/ciano para parecer o NvChad
    primary: '#6c9bf5'     # regular4 (azul dominante nos widgets)
    secondary: '#7afde1'   # regular2 (ciano para foco e seleções)
    accent: '#64e0ff'      # regular6 (azul claro em vez de rosa para o cursor/foco)
    surface: '#304b66'     # bright0 (painéis e separadores)
    
    # Feedback Visual
    success: '#7afde1'     # regular2 (ciano)
    warning: '#fff09b'     # regular3 (amarelo)
    error: '#fc644d'       # regular1 (o rosa/vermelho fica restrito a erros)
    
    # Métodos HTTP: Cores sólidas da sua paleta
    method:
      get: '#7afde1'       # ciano
      post: '#6c9bf5'      # azul
      put: '#fff09b'       # amarelo
      delete: '#fc644d'    # vermelho/rosa
  '';

  home.file.".config/posting/config.yaml".text = ''
    theme: rapture
    # Como você usa alpha no foot, talvez queira que o Posting seja transparente?
    # Se sim, o terminal precisa suportar e o background aqui deve ser omitido ou "transparent"
  '';

  home.packages = with pkgs; [
    agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    # unstable.code-cursor
    wl-clipboard
    moonlight-qt
    cryptsetup
    fastfetch
    otpclient
    discord
    lazygit
    swappy
    chafa
    brave
    slurp
    grim
    age
  ];
}
