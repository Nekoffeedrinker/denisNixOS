{inputs, ...}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    # Instalar Niri
    programs.niri.enable = true;

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
      # Controlar el brillo del monitor
      pkgs.brightnessctl

      # Herramienta para ejecutar apps X11 en Wayland
      pkgs.xwayland-satellite

      # Temas e iconos
      pkgs.adwaita-icon-theme
      pkgs.hicolor-icon-theme

      # App para que algunas apps flotantes sigan
      # el espacio de trabajo actual.
      inputs.niri-float-sticky.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
