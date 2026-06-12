{self, ...}: {
  flake.nixosModules.thinkpadx13Programs = {pkgs, ...}: {
    imports = [
      self.nixosModules.flatpak
      self.nixosModules.basicos
      # === Aplicaciones ===
      self.nixosModules.doomEmacs
      self.nixosModules.miniJuegos
      self.nixosModules.steam
      self.nixosModules.minecraft
      self.nixosModules.virtManager
      self.nixosModules.prodAudio
      self.nixosModules.prodImagen
      self.nixosModules.prodVideo
      self.nixosModules.affinity
      self.nixosModules.davinciResolveIntel
      self.nixosModules.teatro
    ];

    # ===================== Paquetes / Programas =====================

    # Habilitar paquetes no libres (no Open Source)
    nixpkgs.config.allowUnfree = true;

    # Paquetes en Nixpkgs
    environment.systemPackages = with pkgs; [
      flameshot # capturas de pantalla

      # Herramientas de terminal
      nvtopPackages.intel # monitor de la gráfica

      # Terminal divertida
      sl # steam locomotive

      # Herramientas Gui
      obsidian
      qalculate-gtk
      tangram # contenedor para webapps

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
      freecad
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
        "io.github.nokse22.asciidraw"
        "com.mardojai.DiccionarioLengua"
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
