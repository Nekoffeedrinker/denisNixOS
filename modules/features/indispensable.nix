{self, ...}: {
  flake.nixosModules.indispensable = {pkgs, ...}: {
    # Acá se listan paquetes y configuraciones que activo siempre.

    # Importar otros archivos
    imports = [
      self.nixosModules.nixUtil
    ];

    # Activar Flakes
    nix.settings.experimental-features = ["nix-command" "flakes"];

    # =============== Seguridad ===============

    # Mostrar caracteres de contraseña en el sudo
    security.sudo.extraConfig = ''
      Defaults pwfeedback
    '';

    # =============== Paquetes ===============

    # Habilitar paquetes no libres (no Open Source)
    nixpkgs.config.allowUnfree = true;

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
      tmux

      # Está bien tenerlas
      fastfetch
      hyfetch # pride fetch
      btop # monitor de recursos
      ncdu # analizar el espacio en disco

      # Terminal divertida
      cbonsai # arbol bonsai
      cmatrix # caracteres cayendo en cascada
      fortune-kind # como una galleta china
      sl # steam locomotive
      # Arte ASCII
      figlet # escrito en letras grandes
      cowsay # una vaca diciendo cosas
    ];
  };
}
