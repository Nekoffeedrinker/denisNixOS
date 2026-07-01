{self, ...}: {
  flake.nixosModules.vmguestPrograms = {pkgs, ...}: {
    imports = [
      self.nixosModules.flatpak
      self.nixosModules.fishShell
      # === Aplicaciones ===
      # self.nixosModules.doomEmacs
    ];

    # ===================== Paquetes / Programas =====================

    # Establecer la shell por defecto
    users.defaultUserShell = pkgs.fish;

    # Paquetes en Nixpkgs
    environment.systemPackages = with pkgs; [
      spice-vdagent # Cosas de maquina virutal
      kitty
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
