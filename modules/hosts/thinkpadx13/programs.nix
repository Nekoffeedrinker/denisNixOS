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

    # Instalar Team Viewer
    services.teamviewer.enable = true;

    # Paquetes en Nixpkgs
    environment.systemPackages = with pkgs;
      [
        nvtopPackages.intel # monitor de la gráfica
        flameshot # capturas de pantalla

        # Herramientas de terminal
        kitty
        fzf # búsqueda chida
        usbutils # trabajar con USB

        # Herramientas Gui
        gparted
        font-manager
        mission-center
        easyeffects
        file-roller # Abrir archivos comprimidos

        # General
        obsidian
        calibre
        foliate # eBook reader
        komikku # Manga reader
        qalculate-gtk
        dialect # Traductor de texto
        amberol # Reproductor de música
        pix # Visor de imágenes
        gimagereader # gui para tesseract-ocr
        identity # comparar imágenes/videos
        czkawka # búsqueda de archivos duplicados

        # Real Life
        blanket # reproducir sonidos ambientales
        shortwave # Sintonizar radios de internet

        # Ofimática
        miktex
        texlab # LSP de LaTeX
        typst
        tinymist # LSP de typst
        kdePackages.okular
        pdfarranger
        libreoffice
        onlyoffice-desktopeditors
        zotero

        # Código
        texstudio
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
        paleta # Paleta de colores de una imágen
        contrast # checar contraste entre colores

        # Teatro
        qlcplus

        # Juegos
        prismlauncher # Minecraft
        lutris
        dolphin-emu
      ]
      ++ (with pkgs-unstable; [
        # --- Paquetes de inestable ---

        gitte # cliente GUI de git
        trayscale # GUI para Tailscale
        opencode
        mousam # app del clima
      ]);

    # Paquetes en Flathub
    services.flatpak.packages =
      map (id: {
        appId = id;
        origin = "flathub";
      }) [
        # Herramientas Gui
        # "com.parsecgaming.parsec"
        "dev.geopjr.Collision" # Verificar archivos
        "io.github.vmkspv.lenspect"

        # General
        "com.rtosta.zapzap"
        "com.discordapp.Discord"
        "com.spotify.Client"
        "com.bitwarden.desktop"

        # Navegadores
        "app.zen_browser.zen"

        # Productividad
        "io.github.focustimerhq.FocusTimer"
        "com.super_productivity.SuperProductivity"
        "com.remnote.RemNote"
        "com.logseq.Logseq"
        "com.mardojai.DiccionarioLengua"
        "io.gitlab.persiangolf.voicegen"
        "org.gnome.gitlab.somas.Apostrophe"
        # "io.github.nokse22.asciidraw"

        # Audio
        # "org.audacityteam.Audacity"
        # "com.bitwig.BitwigStudio"
        "org.musescore.MuseScore"

        # Video
        "no.mifi.losslesscut"
        "com.dec05eba.gpu_screen_recorder"

        # Imagen
        "com.icons8.Lunacy"
        "art.fatdawlf.Piccolo"
        "io.github.shonebinu.Defuse"
        "com.github.tenderowl.frog"

        # Teatro
        "org.linuxshowplayer.LinuxShowPlayer"
      ]
      ++ [
        rec {
          appId = "dk.nikse.subtitleedit";
          sha256 = "1lgv11bd0m5nzf2zzb6zac8llm306qrlxh2pyxqjhzf9qxnp2z7h";
          bundle = "${pkgs.fetchurl {
            url = "https://github.com/SubtitleEdit/subtitleedit/releases/download/v5.1.0/SubtitleEdit-linux-x64.flatpak";
            inherit sha256;
          }}";
        }
        rec {
          appId = "com.buxjr.melia";
          sha256 = "15dwa5y09ng8cjxd18n4r4wkvaipj17m9cylslf69lg9db7mcnqq";
          bundle = "${pkgs.fetchurl {
            url = "https://github.com/buxjr311/melia-app/releases/download/v1.1.367/melia_1.1.367_x64.flatpak";
            inherit sha256;
          }}";
        }

        /*

        Estos `rec` son para instalar flatpak bundles (que pueden ser conjuntos
        de programas o un solo programa). Esto sirve para instalar algún paquete
        que no esté dentro de los repositorios de flathub. Gracias a que los
        flatpak son un formato libre cualqueira puede publicar y distribuir de
        esta manera.

        Existe una manera para instalarlos desde el disco, pero yo en cambio usé
        una en la que el paquete se descarga de internet, se valida su hash
        (para verificar que se descargó el instaldor correcto) y se instala en
        el sistema.

        Para ello se ocupa:

        - appId: nombre de la aplicación.
        - url: enlace de internet que inicia la descarga (ojo, no es el sito
          web, sino el enlace al que clickeas para descargar).
        - sha256: hash único que verifica que el archivo que descargaste es el
          correcto y no se corrompió durante la descarga.

        Para obtener el hash sha256, ejecuta `nix-prefetch-url` y la url del
        flatpak en cuestión, lo que devolverá el path y hash correspondiente.
        Ejemplo:

        ```
        ❯ nix-prefetch-url https://github.com/SubtitleEdit/subtitleedit/releases/download/v5.0.0/SubtitleEdit-linux-x64.flatpak
        path is '/nix/store/96hb35gvipy3l0vailpyw78niimcxrwa-SubtitleEdit-linux-x64.flatpak'
        0s7f34f4y2c2frs348yaf7x0694rrn9w03p86yr6gs32rkk82qzd
        ```

        Cabe resaltar que esto instala una versión específica ligada a una
        release. si quisieramos instalar una versión más nueva, hay que cambiar
        el url y hash.

        */
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
