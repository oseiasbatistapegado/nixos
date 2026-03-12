{ ... }:

{
  networking.hostName = "huginn";

  # hardware-configuration.nix é adicionado pelo flake quando o arquivo existe (gerado com nixos-generate-config --dir hosts/huginn)
  imports = [
    ../modules/common/audio.nix
    ../modules/common/flake.nix
    ../modules/common/keyboard.nix
    ../modules/common/locale.nix
    ../modules/common/network.nix
    ../modules/common/packages.nix
    ../modules/common/timezone.nix
    ../modules/common/users.nix
    ../modules/common/version.nix
    ./huginn/boot.nix
    ./huginn/dm.nix
    ./huginn/network.nix
    ./huginn/packages.nix
    ./huginn/systemd.nix
    ./huginn/optional.nix
  ];
}
