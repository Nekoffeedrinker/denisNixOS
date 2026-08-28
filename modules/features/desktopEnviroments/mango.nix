{inputs, ...}: {
  flake.nixosModules.mango = {pkgs, ...}: {
    imports = [
      inputs.mangowm.nixosModules.mango
    ];

    programs.mango.enable = true;

    # Activar portal (interfaz para que apps en
    # Wayland accedan a archivos, pantalla, etc.)
    xdg.portal = {
      enable = true;
      wlr = {
        enable = true;
        settings.screencast = {
          chooser_type = "dmenu";
          chooser_cmd = "${pkgs.rofi}/bin/rofi -dmenu";
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    # Activar polkit (sitema para autorizar
    # aplicaciones para realizar accionces root)
    security.polkit.enable = true;

    # Comunicarse con reproductores de medios
    # (atajos para pausar y reproducir)
    services.playerctld.enable = true;

    environment.systemPackages = with pkgs; [
      wl-clipboard
      wtype # simular teclado
      rofi

      # Controlar el brillo del monitor
      brightnessctl

      # Herramienta para ejecutar apps X11 en Wayland
      xwayland-satellite

      # Temas e iconos
      adwaita-icon-theme
      hicolor-icon-theme

      # QT
      kdePackages.breeze
      qt6Packages.qt6ct
      libsForQt5.qt5ct

      # Cursor de mouse
      bibata-cursors
    ];

    environment.variables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };
  };
}
