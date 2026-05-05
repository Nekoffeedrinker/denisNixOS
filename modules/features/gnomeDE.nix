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
      # (gnomeExtensions.copyous.overrideAttrs (old: {
      #   buildInputs =
      #     (old.buildInputs or [])
      #     ++ [
      #       pkgs.libgda5
      #     ];

      #   preInstall =
      #     (old.preInstall or "")
      #     + ''
      #       sed -i "1i import GIRepository from 'gi://GIRepository';\nGIRepository.Repository.dup_default().prepend_search_path('${pkgs.libgda5}/lib/girepository-1.0');\nGIRepository.Repository.dup_default().prepend_search_path('${pkgs.gsound}/lib/girepository-1.0');\n" lib/preferences/dependencies/dependencies.js

      #       sed -i "1i import GIRepository from 'gi://GIRepository';\nGIRepository.Repository.dup_default().prepend_search_path('${pkgs.libgda5}/lib/girepository-1.0');\n" lib/misc/db.js
      #     '';
      # }))
      # dependencias copyous
      libgda6
      gsound
      gnomeExtensions.status-tray
      gnomeExtensions.launch-new-instance
      gnomeExtensions.pip-on-top
    ];
  };
}
