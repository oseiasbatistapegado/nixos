{ ... }:

{
  services.earlyoom.enable = true;

  systemd.tmpfiles.rules = [
    "d /tmp/.X11-unix 1777 root root -"
  ];
}
