{self, ...}: {
  flake.nixosModules.indispensable = {pkgs, ...}: {
    # Acá van las configuraciones mínimas indispensables para todas mis máquinas.

    # =============== Importar ===============
    imports = [
      self.nixosModules.nixUtil
    ];

    # =============== Localización ===============

    # Lenguaje del sistema y formato de fecha y hora
    i18n.defaultLocale = "es_MX.UTF-8";

    # Zona horaria
    time.timeZone = "America/Mazatlan";

    # =============== Servicios ===============

    # Activar la configuración de redes
    networking.networkmanager.enable = true;

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

    # =============== Seguridad ===============

    # Mostrar caracteres de contraseña en el sudo
    security.sudo.extraConfig = ''
      Defaults pwfeedback
    '';

    # =============== Paquetes ===============
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
