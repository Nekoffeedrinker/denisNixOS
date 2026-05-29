{self, ...}: {
  flake.nixosModules.teatro = {pkgs, ...}: {
    imports = [
      self.nixosModules.flatpak
    ];

    # Paquetes
    environment.systemPackages = with pkgs; [
      pwvucontrol # volumen e interfaces de audio
      crosspipe # Rutear el audio
      qlcplus
    ];

    # Flatpak
    services.flatpak.packages =
      map (id: {
        appId = id;
        origin = "flathub";
      }) [
        "org.linuxshowplayer.LinuxShowPlayer"
      ];
  };
}
