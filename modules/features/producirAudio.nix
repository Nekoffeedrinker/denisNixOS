{...}: {
  flake.nixosModules.prodAudio = {pkgs, ...}: {
    # Paquetes
    environment.systemPackages = with pkgs; [
      pwvucontrol # volumen e interfaces de audio
      crosspipe # Rutear el audio

      ardour
    ];

    # Flatpak
    services.flatpak.packages = [
      {
        appId = "org.audacityteam.Audacity";
        origin = "flathub";
      }
      {
        appId = "com.bitwig.BitwigStudio";
        origin = "flathub";
      }
    ];
  };
}
