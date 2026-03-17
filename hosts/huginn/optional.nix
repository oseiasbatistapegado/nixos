{ pkgs, ... }:

{
  # Samsung Chromebook 4: habilitar se tiver bluetooth.
  hardware.bluetooth.enable = true;

  # Sem impressora no huginn.
  services.printing.enable = false;

  services.openssh.enable = false;

  users.users.tux.shell = pkgs.fish;

  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0660"
  '';

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "JetBrainsMono Nerd Font" ];
      serif = [ "JetBrainsMono Nerd Font" ];
    };
  };

  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 150;
    algorithm = "zstd";
  };
}
