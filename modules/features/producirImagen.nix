{...}: {
  flake.nixosModules.prodImagen = {pkgs, ...}: {
    # Paquetes
    environment.systemPackages = with pkgs; [
      eyedropper
      gimp
      inkscape
      lunacy
      scribus
    ];

    # Flatpak
    services.flatpak.packages = [
      # Aquí instalar los flatpaks
    ];
  };
}
