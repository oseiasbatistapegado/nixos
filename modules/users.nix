{ pkgs, ... }:

{
  users.users.tux = {
    isNormalUser = true;
    uid = 1000;
    group = "users";
    description = "tux";
    extraGroups = [ "networkmanager" "wheel" "video" "render" ];
  };
}