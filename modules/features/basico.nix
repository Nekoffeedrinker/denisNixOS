{self, ...}: {
  flake.nixosModules.basicos = {pkgs, ...}: {
    # =============== Importar ===============
    imports = [
      self.nixosModules.indispensable
      self.nixosModules.zsh
    ];

    # =============== Servicios ===============

    # Imprimir documentos usando CUPS
    services.printing.enable = true;

    # =============== Paquetes ===============
    environment.systemPackages = with pkgs; [
      # Terminal (cli)
      kitty
      delta # pager de git diff
      opencode
      tree # arbol de directorios
      fzf # búsqueda chida
      bat # cat mejorado
      eza # ls mejorado
      fd # find mejorado
      ripgrep # grep mejorado (se usa `rg`)
      usbutils # trabajar con USB
      ncdu # analizar el espacio en disco
      (yazi.override {
        _7zz = _7zz-rar;
      })
      # Arte ASCII
      figlet # escrito en letras grandes
      cowsay # una vaca diciendo cosas
      # “terminal fun”
      cbonsai # arbol bonsai
      cmatrix # caracteres cayendo en cascada
      fortune-kind # como una galleta china
      sl # steam locomotive

      # Gui
      easyeffects
      font-manager
      gparted
      mission-center
    ];

    programs.localsend.enable = true;
  };
}
