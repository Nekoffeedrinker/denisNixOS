{...}: {
  flake.nixosModules.prodVideo = {pkgs, ...}: {
    # Paquetes
    environment.systemPackages = with pkgs; [
      kdePackages.kdenlive
      obs-studio
    ];

    # Flatpak
    services.flatpak.packages = [
      # Aquí instalar los flatpaks
    ];
  };
}
