{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.thinkpadx13Configuration = {
    pkgs,
    mainUser,
    ...
  }: {
    # Importar otros módulos
    imports = [
      self.nixosModules.thinkpadx13Hardware
      # = Entorno de escritorio =
      self.nixosModules.denisNiri
      self.nixosModules.denisNoctalia
      self.nixosModules.denisNoctaliaBTh
      # self.nixosModules.denisDMS
      # = Aplicaciones =
      self.nixosModules.paquetesDoomEmacs
      self.nixosModules.virtManager
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Acá inicia la configuración de nix -------------------------------------

    # ==================== Boot / Hardare ====================

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

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Perfil de energía y batería
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    # Enable sound with pipewire.
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

    # Arreglar el reloj al arrancar en windows
    time.hardwareClockInLocalTime = true;

    # ==================== Puntos de montaje ====================

    # Punto de montaje de mi carpeta Gatos
    # fileSystems."/mnt/GATOS" = {
    #   device = "/dev/disk/by-uuid/10d308dd-afc2-4647-99c7-6165285d6e7b";
    #   fsType = "ext4";
    #   options = ["defaults"];
    # };

    # ==================== Internet / Bluetooth ====================

    # Internet
    networking.networkmanager.enable = true;
    networking.wireless.enable = true;
    networking.hostName = "thinkpadx13";

    # Bluetooth
    hardware.bluetooth.enable = true;

    # Proxy
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # ==================== Localización ====================

    # Set your time zone.
    time.timeZone = "America/Mazatlan";

    # Select internationalisation properties.
    i18n.defaultLocale = "es_MX.UTF-8";

    # ==================== Usuarios ====================

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

    # ==================== Seguridad ====================

    # Mostrar caracteres de contraseña en el sudo
    security.sudo.extraConfig = ''
      Defaults pwfeedback
    '';

    # ==================== Paquetes / Programas ====================

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      #
      # Terminal (cli)
      arduino-cli
      btop # monitor de recursos
      fastfetch
      hyfetch # pride fetch
      fd # find mejorado
      kitty
      neovim
      ncdu # analizar el espacio en disco
      ripgrep # grep mejorado (se usa `rg`)
      sl # steam locomotive
      stow
      syncthing
      tree # arbol de directorios
      typst
      usbutils
      wget
      (yazi.override {
        _7zz = _7zz-rar;
      })

      # Git
      git
      delta # pager de git mejorado

      # Zsh: dependencias y alias
      zsh
      zoxide # para usarlo en zsh
      fzf # para usar fzf-tab en zsh
      bat # cat mejorado
      eza # ls mejorado

      # Gui
      blanket # reproducir sonidos ambientales
      eyedropper
      font-manager
      flameshot # capturas de pantalla
      gparted
      inkscape
      kdePackages.okular
      kdePackages.kdenlive
      localsend
      lunacy
      meld
      obsidian
      onlyoffice-desktopeditors
      parsec-bin
      spotify
      tangram # contenedor para webapps
      vscode
      zapzap
      zotero

      # Relacionado a Nix
      alejandra # code formatter
      nixd # lsp
      nh # nix helper
      nix-output-monitor # nix-binary bonito
      nvd # diferencias entre generaciones
    ];

    # Configuración de nixd
    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    # Install firefox.
    programs.firefox.enable = true;

    # Habilitar Zsh
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    # Habilitar Tailscale
    services.tailscale.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in sudo usermod -a -G input $USERuser sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

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

    # ==================== Entorno de escritorio ====================

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # ==================== Variables de entorno ====================

    environment.sessionVariables = {
      NH_FLAKE = "/home/denis/denisNixOS/";
    };

    # ==================== Servicios ====================

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

    # ==================== Sistem state version ====================

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
