{self, ...}: {
  flake.nixosModules.indispensable = {pkgs, ...}: {
    # Acá se listan paquetes y configuraciones que activo siempre.

    # Importar otros archivos
    imports = [
      self.nixosModules.nixUtil
    ];


    # =============== Seguridad ===============

    # Mostrar caracteres de contraseña en el sudo
    security.sudo.extraConfig = ''
      Defaults pwfeedback
    '';

    # =============== Paquetes ===============

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
    ];
  };
}
