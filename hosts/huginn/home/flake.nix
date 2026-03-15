{ pkgs, unstable, nvchad4nix, ... }:

let
  secrets = import ../secrets.nix;
in
{
  imports = [
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

  home.sessionVariables = {
    GEMINI_API_KEY = secrets.gemini_api_key;
    NIXOS_OZONE_WL = "1";
  };
}
