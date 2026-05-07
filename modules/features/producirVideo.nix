{...}: {
  flake.nixosModules.prodVideo = {pkgs, ...}: {
    # Paquetes
    environment.systemPackages = with pkgs; [
      kdePackages.kdenlive
      obs-studio
    ];

    # Flatpak
    services.flatpak.packages = [
      {
        appId = "no.mifi.losslesscut";
        origin = "flathub";
      }
    ];
  };
}
