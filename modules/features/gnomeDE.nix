{...}: {
  flake.nixosModules.gnome = {pkgs, ...}: {
    # Instalar el entorno de escritorio GNOME
    services.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = with pkgs; [
      gnome-font-viewer # Tipografías
      gnome-connections # Conexiones
      gnome-contacts # Contactos
      gnome-maps # Mapas
      gnome-weather # Meteorología
      gnome-tour # Tour
      yelp # Ayuda
      # gnome-system-monitor # Monitor del sistema
      # gnome-software      # Software
    ];

    environment.systemPackages = with pkgs; [
      gnome-tweaks
    ];
  };
}
