{self, ...}: {
  flake.nixosModules.thinkpadx13Configuration = {
    pkgs,
    mainUser,
    ...
  }: {
    # Importar otros módulos
    imports = [
      self.nixosModules.thinkpadx13Hardware
      self.nixosModules.basicos
      self.nixosModules.flatpak
      self.nixosModules.appImage
      self.nixosModules.distrobox
      # === Entorno de escritorio ===
      self.nixosModules.gnome
      self.nixosModules.niri
      # self.nixosModules.mango
      self.nixosModules.noctalia
      self.nixosModules.noctaliaBatThresh
      # self.nixosModules.denisDMS
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

    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Acá inicia la configuración de nix -------------------------------------

    # ===================== Boot / Hardare =====================

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Teclado (en X11)
    services.xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "caps:escape_shifted_capslock";
    };

    # Touchpad
    services.libinput.enable = true;

    # Habilitar lector de huellas
    services.fprintd.enable = true;

    # Perfil de energía y batería
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    # ===================== Puntos de montaje =====================

    # Punto de montaje de mi carpeta Gatos
    # fileSystems."/mnt/GATOS" = {
    #   device = "/dev/disk/by-uuid/10d308dd-afc2-4647-99c7-6165285d6e7b";
    #   fsType = "ext4";
    #   options = ["defaults"];
    # };

    # ===================== Internet / Bluetooth =====================

    # Internet
    networking.networkmanager.enable = true;
    networking.wireless.enable = true;
    networking.hostName = "thinkpadx13";

    # Bluetooth
    hardware.bluetooth.enable = true;

    # Proxy
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # ===================== Usuarios =====================

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${mainUser} = {
      isNormalUser = true;
      description = "Denis Pilar";
      extraGroups = ["networkmanager" "wheel"];
      initialPassword = "1234"; # solo para testing
      # packages = with pkgs; [
      #   #  añadir paquetes solo para el usuario
      # ];
    };

    # ===================== Entorno de escritorio =====================

    # Habilitar el sistema de ventanas X11
    services.xserver.enable = true;

    # Habilitar GDM (Genome Display Manager)
    services.displayManager.gdm.enable = true;

    # ===================== Paquetes / Programas =====================

    # Allow unfree packages
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

    # ===================== Variables de entorno =====================

    # Ubicación del flake (necesario para nh)
    environment.sessionVariables = {
      NH_FLAKE = "/home/denis/denisNixOS/";
    };

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

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # ===================== Sistem state version =====================

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?

    # Acá termina la config de nix --------------------------------------------
  };
}
