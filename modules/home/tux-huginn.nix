{ pkgs, unstable, nvchad4nix, ... }:

let
  # Importa o arquivo de segredos
  secrets = import ./secrets.nix;
in
{
  imports = [
    nvchad4nix.homeManagerModule
  ];

  home.sessionVariables = {
    GEMINI_API_KEY = secrets.gemini_api_key;
  };

  home.username = "tux";
  home.homeDirectory = "/home/tux";
  home.stateVersion = "25.11";

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  programs.nvchad = {
    enable = true;
    neovim = unstable.neovim-unwrapped;

    extraPlugins = ''
      return {
        {
          "yetone/avante.nvim",
          event = "VeryLazy",
          lazy = false,
          version = false,
          build = "make",
          opts = {
            provider = "gemini",
            providers = {
              gemini = {
                model = "gemini-1.5-pro-latest",
                temperature = 0,
                max_tokens = 4096,
              },
            },
          },
          dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-tree/nvim-web-devicons",
            "HakonHarnes/img-clip.nvim",
            "MeanderingProgrammer/render-markdown.nvim",
          },
        },
      }
    '';
 
    chadrcConfig = ''
      local M = {}

      M.base46 = {
        theme = "chadtain", -- Definimos o tema base aqui
        transparency = true,
        theme_reload = true,
        changed_themes = {
          chadsidian = {
            base00 = "#111e2a", -- Background Rapture
            base01 = "#1a2a3a", 
            base02 = "#304b66", 
            base03 = "#304b66", 
            base04 = "#c0c9e5", 
            base05 = "#c0c9e5", -- Foreground Rapture
            base06 = "#ffffff", 
            base07 = "#ffffff", 
            base08 = "#fc644d", -- Vermelho
            base09 = "#fc644d", 
            base0A = "#fff09b", -- Amarelo
            base0B = "#7afde1", -- Verde
            base0C = "#64e0ff", -- Ciano
            base0D = "#6c9bf5", -- Azul
            base0E = "#ff4fa1", -- Rosa
            base0F = "#ff4fa1", 
          }
        },
        hl_override = {
          Comment = { fg = "#304b66" },
          ["@comment"] = { fg = "#304b66" },
          ["@keyword"] = { fg = "#ff4fa1" },
          ["@function"] = { fg = "#6c9bf5" },
          ["@variable"] = { fg = "#c0c9e5" },
        },
      }

      M.ui = {
        theme = "chadtain",
        transparency = true,
      }

      return M
    '';

  };

  # Usar Hyprland e portal do NixOS (package = null, portalPackage = null)
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.variables = [ "--all" ];

    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod SHIFT, R, exec, foot --app-id=floating_remote remote-touchpad -bind :38731"
        # Print da tela toda (Full Screen)
        ", Print, exec, grim - | wl-copy"
        
        # Selecionar área e copiar para o clipboard
        "$mod, Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        
        # Selecionar área, editar com Swappy e depois salvar
        "$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | swappy -f -"

        "$mod, L, exec, hyprlock"
        "$mod, R, exec, wofi --show drun"
        "$mod, F, fullscreen"
        "$mod, Return, exec, foot"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod, E, exec, foot -e nnn -C"
        "$mod, V, togglefloating"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Mudar o foco para o workspace (Mod + 1-0)
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Enviar janela ativa para o workspace (Mod + SHIFT + 1-0)
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Scroll através dos workspaces (Mod + Mouse Wheel)
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      monitor = [
        "eDP-1,disable"
        "DP-1,preferred,auto,1"
      ];
      exec-once = [
        "dbus-update-activation-environment --systemd --all"
	      "waybar"
      ];
      input = {
        kb_layout = "br";
        follow_mouse = 1;
        sensitivity = 0.0;
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.inactive_border" = "rgba(595959aa)";
        "col.active_border" = "rgba(33ccffaa)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
	blur = {
	  enabled = true;
	  size = 3;
	  passes = 1;
	  new_optimizations = true;
	};
	shadow = {
	  enabled = true;
	  range = 4;
	  render_power = 3;
	  color = "rgba(1a1a1aee)";
	};
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [ "windows, 1, 7, myBezier" "windowsOut, 1, 7, default, popin 80%" "border, 1, 10, default" "fade, 1, 7, default" "workspaces, 1, 6, default" ];
      };
      misc = {
        force_default_wallpaper = 0;
      };
    };
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=14";
	shell = "${pkgs.fish}/bin/fish";
      };

      # Remova o bloco 'cursor' inteiramente se ele estiver apenas definindo cores.
      # Se quiser definir o estilo (block, beam, etc), mantenha apenas isso:
      cursor = {
        style = "beam";
        blink = "no";
      };

      colors = {
        background = "111e2a";
        foreground = "c0c9e5";

        # ESTA É A MUDANÇA: O Foot agora quer estas chaves exatas aqui
        cursor = "111e2a ffffff";      # Cor do bloco do cursor
        # text-cursor = "111e2a"; # Cor do texto dentro do cursor

        selection-foreground = "ffffff";
        selection-background = "304b66";

        ## Palette Rapture
        regular0 = "000000";
        regular1 = "fc644d";
        regular2 = "7afde1";
        regular3 = "fff09b";
        regular4 = "6c9bf5";
        regular5 = "ff4fa1";
        regular6 = "64e0ff";
        regular7 = "c0c9e5";

        bright0 = "304b66";
        bright1 = "fc644d";
        bright2 = "7afde1";
        bright3 = "fff09b";
        bright4 = "6c9bf5";
        bright5 = "ff4fa1";
        bright6 = "64e0ff";
        bright7 = "ffffff";
        
        alpha = 0.85; 
      };
    };
  };

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
      add_newline = false;
      # O Starship é sensível à ordem e hierarquia
      format = "$directory$git_branch$git_status$golang$ruby$character"; # Mudamos de $char para $character

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

  # Habilitar o direnv (essencial para Go/Ruby no NixOS)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # enableFishIntegration = true;
  };

  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      width = 400;
      height = 300;
      always_run = true;
      show = "drun"; # Mostra apenas aplicativos instalados
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = false;

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
        font-size: 13px;
      }
      window#waybar {
        background: rgba(43, 48, 59, 0.5);
        border-bottom: 2px solid rgba(100, 114, 125, 0.5);
        color: white;
      }
      #workspaces button,
      #cpu,
      #memory,
      #disk,
      #battery,
      #pulseaudio,
      #bluetooth,
      #clock {
        padding: 0 10px;
        margin: 0 4px;
      }
      #workspaces button.active {
        background-color: rgba(51, 204, 255, 0.66); 
        border-radius: 5px;
        color: #ffffff;
      }
    '';

    settings = {
      mainBar = {
        layer = "top";
	      position = "top";
	      modules-left = [ "hyprland/workspaces" ];
	      modules-center = [ "hyprland/window" ];
	      modules-right = [ "pulseaudio" "bluetooth" "cpu" "memory" "disk" "battery" "clock" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "";
          };
          on-click = "activate";
          persistent-workspaces = {
            "DP-1" = [ 1 2 3 4 5 6 7 8 9 10 ];
          };
        };

        cpu = {
          format = "{usage}% ";
        };

        memory = {
          format = "{percentage}% ";
        };

        disk = {
          interval = 30;
          format = "{percentage_used}% ";
          path = "/";
        };

	      battery = {
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
	      };

	      pulseaudio = {
	        format = "{volume}% {icon}";
          format-icons = { default = ["" "" ""]; };
          on-click = "pavucontrol";
        };

        bluetooth = {
          format = "{status} ";
          on-click = "blueman-manager";
        };
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

  # Opcional: hint para Electron usar Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    unstable.code-cursor
    wl-clipboard # Para copiar direto para o CTRL+V
    moonlight-qt
    fastfetch
    otpclient
    swappy  # O "editor" (permite desenhar setas e anotar antes de salvar)
    brave
    slurp   # O "selecionador" (permite escolher a área com o mouse)
    grim    # O "fotógrafo" (captura a tela)
  ];
}
