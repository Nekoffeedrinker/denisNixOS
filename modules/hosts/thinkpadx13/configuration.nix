{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.thinkpadx13Configuration = {
    pkgs,
    lib,
    ...
  }: {
    # import any other modules from here
    imports = [
      self.nixosModules.thinkpadx13Hardware
      #self.nixosModules.niri
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Acá inicia la configuración de nix -------------------------------------

    # ==================== Boot / Hardare ====================

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Añadir fedora al bootloader
    boot.loader.systemd-boot.extraEntries = {
      "fedora.conf" = ''
        title Fedora Linux
        efi /EFI/fedora/grubx64.efi
      '';
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "caps:escape_shifted_capslock";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

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

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # ==================== Puntos de montaje ====================

    # Punto de montaje de mi carpeta Gatos
    fileSystems."/mnt/GATOS" = {
      device = "/dev/disk/by-uuid/10d308dd-afc2-4647-99c7-6165285d6e7b";
      fsType = "ext4";
      options = ["defaults"];
    };

    # ==================== Internet / Bluetooth ====================

    # Internet
    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # ==================== Localización ====================

    # Set your time zone.
    time.timeZone = "America/Mazatlan";

    # Select internationalisation properties.
    i18n.defaultLocale = "es_MX.UTF-8";

    # ==================== Usuarios ====================

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.denis = {
      isNormalUser = true;
      description = "Denis Pilar";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
        #  añadir paquetes solo para el usuario
      ];
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
      # Terminal (cli)
      btop # monitor de recursos
      fastfetch
      git
      kitty
      lf # explorador de archivos en terminal
      neovim
      ncdu # analizar el espacio en disco
      sl # steam locomotive
      stow
      syncthing
      tree # arbol de directorios
      typst
      wget
      zsh

      # Gui
      blanket # reproducir sonidos ambientales
      emacs
      eyedropper
      inkscape
      localsend
      lunacy
      obsidian
      spotify
      tangram # contenedor para webapps
      zapzap

      # Requerido por Doom Emacs
      ripgrep # regex pattern directory searcher
      fd # better `find`
      symbola # Fuente
      nerd-fonts.symbols-only
      shellcheck
      pandoc

      # Relacionado a Nix
      alejandra # code formatter
      nixd # lsp
    ];

    # Configuración de nixd
    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    # Install firefox.
    programs.firefox.enable = true;

    # Habilitar Zsh
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # Tipografías
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.monaspace
      inter
      public-sans
      libertinus
      courier-prime
    ];

    # ==================== Entorno de escritorio ====================

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # ==================== Variables de entorno ====================

    environment.sessionVariables = {
      PATH = ["$HOME/.emacs.d/bin"];
    };

    # ==================== Servicios ====================

    # Iniciar Syncthing
    #services = {
    #    syncthing = {
    #        enable = true;
    #        user = "denis";
    #        group = "users";
    #        dataDir = "/mnt/GATOS/Syncthing";    # Default folder for new synced folders
    #        configDir = "/mnt/GATOS/.config/syncthing";   # Folder for Syncthing's settings and keys
    #    };
    #};

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
