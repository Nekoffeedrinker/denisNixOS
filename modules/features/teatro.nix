{...}: {
  flake.nixosModules.teatro = {pkgs, ...}: {
    # Paquetes
    environment.systemPackages = with pkgs; [
      pwvucontrol # volumen e interfaces de audio
      crosspipe # Rutear el audio
      qlcplus
    ];

    # Flatpak
    services.flatpak.packages = [
      # Linux Show Player flatpack
      {
        appId = "org.linuxshowplayer.LinuxShowPlayer";
        origin = "flathub";
      }
    ];
  };
}
