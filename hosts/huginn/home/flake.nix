{ pkgs, unstable, nvchad4nix, agenix, config, ... }:

{
  imports = [
    agenix.homeManagerModules.age
    nvchad4nix.homeManagerModule
    ./hyprland.nix
    ./qt-gtk.nix
    ./foot.nix
    ./shell.nix
    ./utils.nix
    ./nvchad.nix
  ];

  home.username = "tux";
  home.homeDirectory = "/home/tux";
  home.stateVersion = "25.11";

  age = {
    identityPaths = [ "/run/media/tux/key/key.txt" ];

    secrets = {
      gemini_api_key = {
        file = ./gemini_api_key.age;
        path = "${config.home.homeDirectory}/.config/gemini_key";
      };
      ssh_private_personal = {
        file = ./ssh_private_personal.age;
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_personal";
      };
      ssh_public_personal = {
        file = ./ssh_public_personal.age;
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_personal.pub";
      };
      ssh_private_mk = {
        file = ./ssh_private_mk.age;
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_mk";
      };
      ssh_public_mk = {
        file = ./ssh_public_mk.age;
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_mk.pub";
      };
      ssh_private_fenrir = {
        file = ./ssh_private_fenrir.age;
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_fenrir";
      };
      ssh_public_fenrir = {
        file = ./ssh_public_fenrir.age;
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_fenrir.pub";
      };
      ssh_private_mk_server = {
        file = ./ssh_private_mk_server.age;
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_mk_server";
      };
      ssh_public_mk_server = {
        file = ./ssh_public_mk_server.age;
        path = "${config.home.homeDirectory}/.ssh/id_ed25519_mk_server.pub";
      };
      otp_aegis = {
        file = ./otp_aegis.age;
        path = "${config.home.homeDirectory}/Documents/aegis_dump.json";
      };
    };
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
