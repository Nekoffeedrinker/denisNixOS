{inputs, ...}: {
  flake.nixosModules.mango = {pkgs, ...}: {
    imports = [
      inputs.mangowm.nixosModules.mango
    ];

    programs.mango.enable = true;

    # Activar portal (interfaz para que apps en
    # Wayland accedan a archivos, pantalla, etc.)
    xdg.portal.enable = true;
    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    # Activar polkit (sitema para autorizar
    # aplicaciones para realizar accionces root)
    security.polkit.enable = true;

    # Comunicarse con reproductores de medios
    # (atajos para pausar y reproducir)
    services.playerctld.enable = true;

    environment.systemPackages = [
      pkgs.wl-clipboard
      pkgs.foot
      pkgs.rofi

      # Controlar el brillo del monitor
      pkgs.brightnessctl

      # Herramienta para ejecutar apps X11 en Wayland
      pkgs.xwayland-satellite

      # Temas e iconos
      pkgs.adwaita-icon-theme
      pkgs.hicolor-icon-theme

      # QT
      pkgs.kdePackages.breeze
      pkgs.qt6Packages.qt6ct
      pkgs.libsForQt5.qt5ct
    ];

    environment.variables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };
  };
}
