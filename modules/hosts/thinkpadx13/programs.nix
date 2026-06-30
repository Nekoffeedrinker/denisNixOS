{self, ...}: {
  flake.nixosModules.thinkpadx13Programs = {pkgs, ...}: {
    imports = [
      self.nixosModules.flatpak
      self.nixosModules.zsh
      self.nixosModules.fishShell
      # === Aplicaciones ===
      self.nixosModules.heliumBrowser
      self.nixosModules.doomEmacs
      self.nixosModules.virtManager
      # self.nixosModules.affinity
      self.nixosModules.davinciResolveIntel
      # === Juegos ===
      self.nixosModules.miniJuegos
      self.nixosModules.steam
      self.nixosModules.minecraft
    ];

    # ===================== Paquetes / Programas =====================

    # Establecer la shell por defecto
    users.defaultUserShell = pkgs.fish;

    # Instalar LocalSend
    programs.localsend.enable = true;

    # Paquetes en Nixpkgs
    environment.systemPackages = with pkgs; [
      nvtopPackages.intel # monitor de la gráfica
      flameshot # capturas de pantalla

      # Herramientas de terminal
      kitty
      opencode
      fzf # búsqueda chida
      usbutils # trabajar con USB
      ncdu # analizar el espacio en disco

      # Terminal divertida
      cbonsai # arbol bonsai
      cmatrix # caracteres cayendo en cascada
      fortune-kind # como una galleta china
      sl # steam locomotive
      # Arte ASCII
      figlet # escrito en letras grandes
      cowsay # una vaca diciendo cosas

      # Herramientas Gui
      gparted
      pix #visor de imágenes
      font-manager
      mission-center
      easyeffects
      gimagereader

      # General
      brave
      obsidian
      super-productivity
      calibre
      qalculate-gtk

      # Real Life
      zapzap
      spotify
      blanket # reproducir sonidos ambientales

      # Ofimática
      typst
      tinymist # LSP de typst
      kdePackages.okular
      pdfarranger
      libreoffice
      onlyoffice-desktopeditors
      zotero

      # Código
      vscode
      meld

      # Elecrónica
      arduino-cli
      kicad
      # freecad

      # Audio
      pwvucontrol # volumen e interfaces de audio
      crosspipe # Rutear el audio
      ardour

      # Video
      kdePackages.kdenlive
      obs-studio
      friction-graphics

      # Imagen
      inkscape
      # gimp
      # scribus
      eyedropper # Obtener un color
      switcheroo # Convertir archivos de imagen
      upscayl # Escalar imágenes

      # Teatro
      qlcplus
    ];

    # Paquetes en Flathub
    services.flatpak.packages =
      map (id: {
        appId = id;
        origin = "flathub";
      }) [
        # Herramientas Gui
        "com.parsecgaming.parsec"
        "dev.geopjr.Collision" # Verificar archivos

        # General
        "app.zen_browser.zen"
        # "io.github.nokse22.asciidraw"

        # Audio
        # "org.audacityteam.Audacity"
        # "com.bitwig.BitwigStudio"

        # Video
        "no.mifi.losslesscut"

        # Imagen
        "com.icons8.Lunacy"
        "io.github.shonebinu.Defuse"

        # Teatro
        "org.linuxshowplayer.LinuxShowPlayer"
      ]
      ++ [
        rec {
          appId = "dk.nikse.subtitleedit";
          sha256 = "6d8e584074bf1aec68eedb65e3c119f3545f2daeb3105367fd5a5db7e694656b";
          bundle = "${pkgs.fetchurl {
            url = "https://github.com/SubtitleEdit/subtitleedit/releases/download/v5.0.0-beta24/SubtitleEdit-linux-x64.flatpak";
            inherit sha256;
          }}";
        }
      ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in sudo usermod -a -G input $USERuser sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };
}
