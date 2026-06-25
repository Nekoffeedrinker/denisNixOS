{self, ...}: {
  flake.nixosModules.thinkpadx13Configuration = {mainUser, ...}: {
    # Importar otros módulos
    imports = [
      # /etc/nixos/hardware-configuration.nix
      self.nixosModules.thinkpadx13Hardware
      self.nixosModules.thinkpadx13Programs
      self.nixosModules.indispensable
      # === Entorno de escritorio ===
      self.nixosModules.gnome
      self.nixosModules.niri
      # self.nixosModules.mango
      # self.nixosModules.denisDMS
      self.nixosModules.noctalia
      self.nixosModules.noctaliaBatThresh
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    # ===================== Boot / Hardare =====================

    # Bootloader.
    boot.loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      # configurationLimit = 3; # cuántas generaciones mostrar
    };
    boot.loader.efi.canTouchEfiVariables = true;

    # Distribución de teclado (en X11)
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

    # Bluetooth
    hardware.bluetooth.enable = true;

    # Wifi
    networking.wireless.enable = true;

    # Imprimir documentos usando CUPS
    services.printing.enable = true;

    # ===================== Puntos de montaje =====================

    # Punto de montaje de mi carpeta Gatos
    # fileSystems."/mnt/GATOS" = {
    #   device = "/dev/disk/by-uuid/10d308dd-afc2-4647-99c7-6165285d6e7b";
    #   fsType = "ext4";
    #   options = ["defaults"];
    # };

    # ===================== Nombres y rutas =====================

    # Nombre de la máquina
    networking.hostName = "thinkpadx13";

    # Ubicación del flake (necesario para nh)
    environment.sessionVariables = {
      NH_FLAKE = "/home/denis/denisNixOS/";
    };

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
