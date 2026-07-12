{...}: {
  flake.nixosModules.cinnamon = {pkgs, ...}: {
    # Instalar el entorno de escritorio Cinnamon
    services.xserver.desktopManager.cinnamon.enable = true;

    # # Display Manager de Cinnamon
    # services.xserver.displayManager.lightdm.enable = true;

    # Instalar dependencias y paquetes extra
    environment.systemPackages = with pkgs; [
      decibels # Reproductor de sonido de GNOME
      snapshot # App de cámara de GNOME
      gnome-system-monitor # Monitor de tareas de GNOME

      nemo-preview # Preview de archivos
      xclip # clipboard para temrinal

      # Dependencias del applet: Automatic dark/light themes
      gnumake
      gcc
    ];
    programs.kdeconnect.enable = true;

    # Clipboard manager
    programs.gpaste.enable = true;
  };
}
