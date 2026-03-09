{ pkgs, ... }:

{
  # Samsung Chromebook 4: habilitar se tiver bluetooth.
  hardware.bluetooth.enable = true;

  # Sem impressora no huginn.
  services.printing.enable = false;

  services.openssh.enable = false;

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
}
