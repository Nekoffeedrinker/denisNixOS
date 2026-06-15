{...}: {
  flake.nixosModules.KdePlasma = {pkgs, ...}: {
    # Este módulo contiene tanto un display manager (el que se usa para iniciar
    # sesión), como el entorno de escritorio. Además, de algunos paquetes extra.

    # Habilitar SDDM (Simple Desktop Display Manager)
    services.displayManager.sddm.enable = true;

    # Instalar el entorno de escritorio KDE Plasma
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.kate
    ];
  };
}
