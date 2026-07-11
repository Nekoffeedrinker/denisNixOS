{self, ...}: {
  flake.nixosModules.thinkpadx13Programs = {
    pkgs,
    pkgs-unstable,
    ...
  }: {
    imports = [
      self.nixosModules.flatpak
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
    ];

    # Establecer la shell por defecto
    users.defaultUserShell = pkgs.fish;

    # ===================== Overlays a inestable =====================

    nixpkgs.overlays = [
      (final: prev: {
        localsend = pkgs-unstable.localsend;
        tailscale = pkgs-unstable.tailscale;
        syncthing = pkgs-unstable.syncthing;
      })
    ];

    # ===================== Paquetes / Programas =====================

    # Instalar LocalSend
    programs.localsend.enable = true;

    # Paquetes en Nixpkgs
    environment.systemPackages = with pkgs;
      [
        nvtopPackages.intel # monitor de la gráfica
        flameshot # capturas de pantalla

        # Herramientas de terminal
        kitty
        opencode
        fzf # búsqueda chida
        usbutils # trabajar con USB

        # Herramientas Gui
        gparted
        font-manager
        mission-center
        easyeffects

        # General
        obsidian
        super-productivity
        calibre
        foliate # eBook reader
        komikku # Manga reader
        qalculate-gtk
        dialect # Traductor de texto
        pix #visor de imágenes
        gimagereader # gui para tesseract-ocr
        identity # comparar imágenes/videos
        czkawka # búsqueda de archivos duplicados

        # Real Life
        zapzap
        spotify
        blanket # reproducir sonidos ambientales
        shortwave # Sintonizar radios de internet

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
        lorem # generador de texto provisional

        # Elecrónica
        arduino-cli
        kicad
        # freecad

        # Audio
        pwvucontrol # volumen e interfaces de audio
        crosspipe # Rutear el audio
        ardour
        eartag # Editar metadatos

        # Video
        kdePackages.kdenlive
        obs-studio
        friction-graphics

        # Imagen
        inkscape
        # gimp
        # scribus
        switcheroo # Convertir archivos de imagen
        upscayl # Escalar imágenes
        eyedropper # Obtener un color
        paleta # Paleta de colores de una imágen
        contrast # checar contraste entre colores

        # Teatro
        qlcplus

        # Juegos
        prismlauncher # Minecraft
        dolphin-emu
      ]
      ++ (with pkgs-unstable; [
        # --- Paquetes de inestable ---

        gitte # cliente GUI de git
        trayscale # GUI para Tailscale
      ]);

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
        "com.brave.Browser"
        "com.bitwarden.desktop"
        "org.gnome.gitlab.somas.Apostrophe"
        "com.mardojai.DiccionarioLengua"
        "io.github.focustimerhq.FocusTimer"
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
          sha256 = "0s7f34f4y2c2frs348yaf7x0694rrn9w03p86yr6gs32rkk82qzd";
          bundle = "${pkgs.fetchurl {
            url = "https://github.com/SubtitleEdit/subtitleedit/releases/download/v5.0.0/SubtitleEdit-linux-x64.flatpak";
            inherit sha256;
          }}";
        }

        ## Para obtener el hash sha256, ejecuta `nix-prefetch-url` y la url del
        ## flatpak en cuestión, lo que devolverá el path y hash correspondiente.
        ## Ejemplo:
        ##
        ## ❯ nix-prefetch-url https://github.com/SubtitleEdit/subtitleedit/releases/download/v5.0.0/SubtitleEdit-linux-x64.flatpak
        ## path is '/nix/store/96hb35gvipy3l0vailpyw78niimcxrwa-SubtitleEdit-linux-x64.flatpak'
        ## 0s7f34f4y2c2frs348yaf7x0694rrn9w03p86yr6gs32rkk82qzd
      ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in sudo usermod -a -G input $USERuser sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # ===================== Servicios =====================

    # Habilitar Tailscale
    services.tailscale.enable = true;

    # Iniciar Syncthing
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = "denis";
      group = "users";
      dataDir = "/home/denis/Syncthing"; # Default folder for new synced folders
      configDir = "/home/denis/.local/state/syncthing"; # Folder for Syncthing's settings and keys
      extraFlags = ["--allow-newer-config"];
    };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };
}
