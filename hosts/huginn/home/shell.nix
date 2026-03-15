{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Remove a mensagem de boas-vindas
      fish_vi_key_bindings # Habilita os atalhos do Vim (ESC para entrar em modo normal)

      fastfetch
    '';
    plugins = [
      {
        name = "nix-env";
        src = pkgs.fishPlugins.foreign-env.src;
      }
    ];
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      command_timeout = 1000;
      add_newline = false;
      # O Starship é sensível à ordem e hierarquia
      format = "$directory$git_branch$git_status$golang$ruby$character"; # Mudamos de $char para $character

      git_status = {
        disabled = true;
      };

      directory = {
        style = "bold #64e0ff";
      };

      # Mudamos o nome da seção de [char] para [character]
      character = {
        success_symbol = "[λ](bold #7afde1) ";
        error_symbol = "[×](bold #fc644d) ";
      };
    };
  };

  xdg.configFile."fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "source": "nixos_small",
	"padding": {
          "top": 1
        }
      },
      "display": {
        "separator": " ➜  "
      },
      "modules": [
        "title",
        "separator",
        "host",
        "display",
        "wm",
        "terminal",
        "cpu",
        "gpu",
        "memory"
      ]
    }
  '';
}
