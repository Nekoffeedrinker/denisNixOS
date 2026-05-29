{self, ...}: {
  flake.nixosModules.prodAudio = {pkgs, ...}: {
    imports = [
      self.nixosModules.flatpak
    ];

    # Paquetes
    environment.systemPackages = with pkgs; [
      pwvucontrol # volumen e interfaces de audio
      crosspipe # Rutear el audio

      ardour
    ];

    # Flatpak
    services.flatpak.packages =
      map (id: {
        appId = id;
        origin = "flathub";
      }) [
        "org.audacityteam.Audacity"
        # "com.bitwig.BitwigStudio"
      ];
  };
}
