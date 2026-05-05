{self, ...}: {
  flake.nixosModules.basicos = {pkgs, ...}: {
    # =============== Importar ===============
    imports = [
      self.nixosModules.nixUtil
      self.nixosModules.zsh
    ];

    # =============== Servicios ===============

    # Imprimir documentos usando CUPS
    services.printing.enable = true;

    # Habilitar sonido con pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Comunicarse con reproductores de medio (atajos para pausar y reproducir)
    services.playerctld.enable = true;

    # =============== Localización ===============

    # Lenguaje del sistema y formato de fecha y hora
    i18n.defaultLocale = "es_MX.UTF-8";

    # Zona horaria
    time.timeZone = "America/Mazatlan";

    # =============== Seguridad ===============

    # Mostrar caracteres de contraseña en el sudo
    security.sudo.extraConfig = ''
      Defaults pwfeedback
    '';

    # =============== Paquetes ===============
    environment.systemPackages = with pkgs; [
      wget

      # Terminal (cli)
      kitty
      neovim
      git
      delta # pager de git diff
      stow
      fastfetch
      hyfetch # pride fetch
      # herramientas
      btop # monitor de recursos
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
      font-manager
      gparted
      localsend
      mission-center
    ];

    # Instalar firefox.
    programs.firefox.enable = true;

    # Tipografías
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      monaspace
      inter
      public-sans
      libertinus
      courier-prime
      roboto
      roboto-serif
      roboto-slab
      corefonts

      # Multiidioma y compatibilidad
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans-static
      noto-fonts-cjk-serif-static
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
    ];
  };
}
