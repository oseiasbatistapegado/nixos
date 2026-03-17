{ pkgs, unstable, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Oséias Batista Pegado";
    userEmail = "oseias.batista.dev@gmail.com";
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

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.ssh = {
    enable = true;
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
        identityFile = "~/.ssh/id_ed25519_personal";
      };
      "mk-server" = {
        hostname = "192.168.1.246";
        user = "mk";
        identityFile = "~/.ssh/id_ed25519_personal";
      };
    };
  };

  home.packages = with pkgs; [
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
    sops
    age
  ];
}
