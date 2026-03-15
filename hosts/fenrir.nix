{ ... }:

{
  networking.hostName = "fenrir";

  # hardware-configuration.nix é adicionado pelo flake quando o arquivo existe (gerado com nixos-generate-config --dir hosts/fenrir)
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
    ./fenrir/boot.nix
    ./fenrir/dm.nix
    ./fenrir/packages.nix
    ./fenrir/systemd.nix
    ./fenrir/optional.nix
  ];
}
