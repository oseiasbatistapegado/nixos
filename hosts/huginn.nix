{ ... }:

{
  networking.hostName = "huginn";

  age = {
    identityPaths = [ "/run/media/tux/key/key.txt" ];
    secrets.k3s_token.file = ./huginn/home/ages/k3s_token.age;
    secrets.tailscale_key.file = ./huginn/home/ages/tailscale_key.age;
  };
  environment.shellAliases = {
    sudo = "doas";
  };

  # hardware-configuration.nix é adicionado pelo flake quando o arquivo existe (gerado com nixos-generate-config --dir hosts/huginn)
  imports = [
    ../modules/audio.nix
    ../modules/flake.nix
    ../modules/keyboard.nix
    ../modules/locale.nix
    ../modules/network.nix
    ../modules/packages.nix
    ../modules/timezone.nix
    ../modules/users.nix
    ../modules/version.nix
    ./huginn/battery.nix
    ./huginn/boot.nix
    ./huginn/dm.nix
    ./huginn/network.nix
    ./huginn/packages.nix
    ./huginn/systemd.nix
    ./huginn/optional.nix
  ];
}
