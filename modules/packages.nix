{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = false;

  services.flatpak = {
    enable = true;

    remotes = {
      flathub = {
        url = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      };
    };
  };

  systemd.services.flatpak-apps = {
    wantedBy = [ "multi-user.target" ];
    after = [
      "network-online.target"
      "dbus.service"
    ];
    wants = [ "network-online.target" ];
    path = [ pkgs.flatpak ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      flatpak install -y --system --noninteractive flathub \
        "com.valvesoftware.Steam" \
        "com.discordapp.Discord" \
        "com.brave.Browser" \
        "org.telegram.desktop" \
        "org.libretro.RetroArch" \
        "org.ppsspp.PPSSPP" \
        "net.pcsx2.PCSX2" \
        "net.rpcs3.RPCS3" \
        "net.shadps4.shadPS4" \
        "com.stremio.Stremio" \
        "org.gnome.Boxes" \
        "com.getpostman.Postman" \
        "io.dbeaver.DBeaverCommunity" \
        "io.github.benjamimgois.goverlay" \
        "org.kde.ktorrent" \
        "net.audiorelay.AudioRelay"
    '';
  };

  # services.flatpak = {
  #   enable = true;
  #   packages = [
  #     "com.valvesoftware.Steam"
  #     "com.discordapp.Discord"
  #     "com.brave.Browser"
  #     "org.telegram.desktop"
  #     "org.libretro.RetroArch"
  #     "org.ppsspp.PPSSPP"
  #     "net.pcsx2.PCSX2"
  #     "net.rpcs3.RPCS3"
  #     "net.shadps4.shadPS4"
  #     "com.stremio.Stremio"
  #     "org.gnome.Boxes"
  #     "com.getpostman.Postman"
  #     "io.dbeaver.DBeaverCommunity"
  #     "io.github.benjamimgois.goverlay"
  #     "org.kde.ktorrent"
  #     "net.audiorelay.AudioRelay"
  #   ];
  # };

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.zenpower
  ];
}