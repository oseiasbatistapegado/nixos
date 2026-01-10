{ ... }:

{
  fileSystems."/media/games" = {
    device = "/dev/disk/by-label/games";
    fsType = "f2fs";
    options = [ "nofail" ];
  };
}