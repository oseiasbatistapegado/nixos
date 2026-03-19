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
      };
      init.defaultBranch = "main";
    };

    includes = [
      {
        condition = "gitdir:~/Documents/mk/";
        contents = {
          user = {
            name = "OseiasMK";
            email = "oseias.batista@mksolutions.com.br";
          };
          core = {
            sshCommand = "ssh -i ~/.ssh/id_ed25519_mk";
          };
        };
      }
    ];
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
      "github.com-mk" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_mk";
      };
      "fenrir" = {
        hostname = "192.168.1.102";
        user = "tux";
        identityFile = "~/.ssh/id_ed25519_fenrir";
      };
      "mk-server" = {
        hostname = "192.168.1.246";
        user = "mk";
        identityFile = "~/.ssh/id_ed25519_mk_server";
      };
    };
  };

  home.packages = with pkgs; [
    agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    # unstable.code-cursor
    wl-clipboard
    moonlight-qt
    cryptsetup
    fastfetch
    otpclient
    swappy
    brave
    slurp
    grim
    age
  ];
}
