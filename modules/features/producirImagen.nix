{self, ...}: {
  flake.nixosModules.prodImagen = {pkgs, ...}: {
    imports = [
      self.nixosModules.flatpak
    ];

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
    services.flatpak.packages =
      map (id: {
        appId = id;
        origin = "flathub";
      }) [
        "com.icons8.Lunacy"
        "io.github.shonebinu.Defuse"
      ];
  };
}
