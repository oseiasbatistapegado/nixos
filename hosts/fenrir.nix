{ ... }:

{
  networking.hostName = "fenrir";

  # hardware-configuration.nix é adicionado pelo flake quando o arquivo existe (gerado com nixos-generate-config --dir hosts/fenrir)
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
    ./fenrir/boot.nix
    ./fenrir/dm.nix
    ./fenrir/packages.nix
    ./fenrir/systemd.nix
    ./fenrir/optional.nix
  ];
}
