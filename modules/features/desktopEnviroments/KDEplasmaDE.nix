{...}: {
  flake.nixosModules.KdePlasma = {pkgs, ...}: {
    # Instalar el entorno de escritorio KDE Plasma
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.kate
    ];
  };
}
