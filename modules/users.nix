{ pkgs, ... }:

{
  users.users.tux = {
    isNormalUser = true;
    description = "tux";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}