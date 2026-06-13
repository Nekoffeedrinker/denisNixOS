{self, ...}: {
  flake.nixosModules.vmguestPrograms = {pkgs, ...}: {
    imports = [
      self.nixosModules.flatpak
      # === Aplicaciones ===
      self.nixosModules.doomEmacs
    ];

    # ===================== Paquetes / Programas =====================

    # Paquetes en Nixpkgs
    environment.systemPackages = with pkgs; [
      fd # find mejorado
      ripgrep # grep mejorado (se usa `rg`)
    ];

    # Paquetes en Flathub
    services.flatpak.packages =
      map (id: {
        appId = id;
        origin = "flathub";
      }) [
        # Herramientas Gui
        "dev.geopjr.Collision" # Verificar archivos
      ];
  };
}
