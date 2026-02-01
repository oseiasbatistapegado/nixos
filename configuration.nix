{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/audio.nix
      ./modules/bluetooth.nix
      ./modules/boot.nix
      ./modules/cups.nix
      ./modules/dm.nix
      ./modules/hostname.nix
      ./modules/keyboard.nix
      ./modules/locale.nix
      ./modules/network.nix
      ./modules/packages.nix
      ./modules/timezone.nix
      ./modules/users.nix
      ./modules/version.nix
      ./modules/flake.nix
      ./modules/ssh.nix
      ./modules/systemd.nix
    ];
}
