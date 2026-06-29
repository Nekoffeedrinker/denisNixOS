{self, ...}: {
  flake.nixosModules.vmguestPrograms = {pkgs, ...}: {
    imports = [
      self.nixosModules.flatpak
      self.nixosModules.zsh
      # === Aplicaciones ===
      # self.nixosModules.doomEmacs
    ];

    # ===================== Paquetes / Programas =====================

    # Establecer la shell por defecto
    users.defaultUserShell = pkgs.zsh;

    # Paquetes en Nixpkgs
    environment.systemPackages = with pkgs; [
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
