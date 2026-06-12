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
      #
      # Terminal (cli)
      arduino-cli
      nvtopPackages.intel # monitor de la gráfica
      sl # steam locomotive
      syncthing
      typst
      tinymist # LSP de typst

      # Gui
      blanket # reproducir sonidos ambientales
      flameshot # capturas de pantalla
      kdePackages.okular
      libreoffice
      meld
      obsidian
      onlyoffice-desktopeditors
      pdfarranger
      spotify
      tangram # contenedor para webapps
      vscode
      zapzap
      zotero
      qalculate-gtk
      kicad
      freecad
    ];

    # Paquetes en Flathub
    services.flatpak.packages =
      map (id: {
        appId = id;
        origin = "flathub";
      }) [
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
