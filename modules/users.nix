{ pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  users.users.tux = {
    isNormalUser = true;
    description = "tux";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.tux = import ./home/tux.nix;
}