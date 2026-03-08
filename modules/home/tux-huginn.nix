{ pkgs, ... }:

{
  home.username = "tux";
  home.homeDirectory = "/home/tux";
  home.stateVersion = "25.11";

  # Usar Hyprland e portal do NixOS (package = null, portalPackage = null)
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.variables = [ "--all" ];

    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, firefox"
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
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      exec-once = [
        "dbus-update-activation-environment --systemd --all"
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
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
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

  programs.kitty.enable = true;

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
