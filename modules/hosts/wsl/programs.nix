{self, ...}: {
  flake.nixosModules.wslPrograms = {pkgs, ...}: {
    imports = [
      # self.nixosModules.flatpak
      self.nixosModules.fishShell
    ];

    # ===================== Paquetes / Programas =====================

    # Establecer la shell por defecto
    users.defaultUserShell = pkgs.fish;

    # Paquetes en Nixpkgs
    environment.systemPackages = with pkgs; [
      opencode
    ];

    # # Paquetes en Flathub
    # services.flatpak.packages =
    #   map (id: {
    #     appId = id;
    #     origin = "flathub";
    #   }) [
    #     # Herramientas Gui
    #     "dev.geopjr.Collision" # Verificar archivos
    #   ];
  };
}
