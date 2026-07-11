{self, ...}: {
  flake.nixosModules.basicPC = {pkgs, ...}: {
    # Estas son las cosas que suelo activar en un host.

    # Importar otros archivos
    imports = [
      self.nixosModules.indispensable
      self.nixosModules.kanata
      self.nixosModules.flatpak
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

    # =============== Paquetes ===============

    services.flatpak.packages = [
      {
        appId = "org.mozilla.firefox";
        origin = "flathub";
      }
    ];

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
