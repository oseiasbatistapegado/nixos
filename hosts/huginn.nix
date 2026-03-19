{ ... }:

{
  networking.hostName = "huginn";

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
