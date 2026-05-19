{...}: {
  flake.nixosModules.prodAudio = {pkgs, ...}: {
    # Paquetes
    environment.systemPackages = with pkgs; [
      pwvucontrol # volumen e interfaces de audio
      crosspipe # Rutear el audio
    ];

    # Flatpak
    services.flatpak.packages = [
      {
        appId = "com.bitwig.BitwigStudio";
        origin = "flathub";
      }
    ];
  };
}
