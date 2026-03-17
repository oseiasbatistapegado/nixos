{ pkgs, unstable, nvchad4nix, sops-nix, config, ... }:

{
  imports = [
    sops-nix.homeManagerModules.sops
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

  sops = {
    defaultSopsFile = ./secrets.yaml; 
    age.keyFile = "/run/media/tux/key/key.txt";

    secrets = {
      "gemini_api_key".path = "${config.home.homeDirectory}/.config/gemini_key";
      "ssh_private_personal".path = "${config.home.homeDirectory}/.ssh/id_ed25519_personal";
      "ssh_public_personal".path = "${config.home.homeDirectory}/.ssh/id_ed25519_personal.pub";
      "ssh_private_mk".path = "${config.home.homeDirectory}/.ssh/id_ed25519_mk";
      "ssh_public_mk".path = "${config.home.homeDirectory}/.ssh/id_ed25519_mk.pub";
      "ssh_private_fenrir".path = "${config.home.homeDirectory}/.ssh/id_ed25519_fenrir";
      "ssh_public_fenrir".path = "${config.home.homeDirectory}/.ssh/id_ed25519_fenrir.pub";
      "ssh_private_mk_server".path = "${config.home.homeDirectory}/.ssh/id_ed25519_mk_server";
      "ssh_public_mk_server".path = "${config.home.homeDirectory}/.ssh/id_ed25519_mk_server.pub";
      "otp_aegis".path = "${config.home.homeDirectory}/Documents/aegis_dump.json";
    };
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
