{ pkgs, unstable, ... }:

{
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

  # Usar Hyprland e portal do NixOS (package = null, portalPackage = null)
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.variables = [ "--all" ];

    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, R, exec, wofi --show drun"
        "$mod, F, fullscreen"
        "$mod, Return, exec, kitty"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod, E, exec, kitty -e nnn -C"
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

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };
    settings = {
      background_opacity = "0.85";
      confirm_os_window_close = 0;
    };
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

  # Opcional: hint para Electron usar Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    unstable.code-cursor
    moonlight-qt
    easyeffects
    otpclient
    discord
    firefox
  ];
}
