{self, ...}: {
  flake.nixosModules.wslPrograms = {pkgs, ...}: {
    imports = [
      self.nixosModules.nixUtil
      # self.nixosModules.flatpak
    ];

    # ===================== Paquetes / Programas =====================

    # Activar fish shell
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

    # Paquetes en Nixpkgs
    environment.systemPackages = with pkgs; [
      wget

      # Minimo indispensable
      neovim
      stow
      git
      delta # pager de git diff
      lazygit
      (yazi.override {
        _7zz = _7zz-rar;
      })
      tree # arbol de directorios
      eza # ls mejorado
      bat # cat mejorado
      fd # find mejorado
      ripgrep # grep mejorado (se usa `rg`)

      # Está bien tenerlas
      fastfetch
      hyfetch # pride fetch
      btop # monitor de recursos

      # Ahora sí las buenas
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
