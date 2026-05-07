{...}: {
  flake.nixosModules.prodImagen = {pkgs, ...}: {
    # Paquetes
    environment.systemPackages = with pkgs; [
      eyedropper
      gimp
      inkscape
      scribus
      switcheroo # Convertir archivos de imagen
      upscayl # Escalar imágenes
    ];

    # Flatpak
    services.flatpak.packages = [
      {
        appId = "com.icons8.Lunacy";
        origin = "flathub";
      }
    ];
  };
}
