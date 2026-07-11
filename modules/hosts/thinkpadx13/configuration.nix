{self, ...}: {
  flake.nixosModules.thinkpadx13Configuration = {mainUser, ...}: {
    imports = [
      # /etc/nixos/hardware-configuration.nix
      self.nixosModules.thinkpadx13Hardware
      self.nixosModules.thinkpadx13Programs
      self.nixosModules.basicPC
      # === Entorno de escritorio ===
      self.nixosModules.cinnamon
      self.nixosModules.niri
      # self.nixosModules.mango
      # self.nixosModules.denisDMS
      self.nixosModules.noctalia
      self.nixosModules.noctaliaBatThresh
    ];

    # ===================== Boot =====================

    # Bootloader.
    boot.loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        # configurationLimit = 3; # cuántas generaciones mostrar
        default = "saved"; # Selecciona la opción del último arranque
      };
      timeout = 3; # segundos
    };
    boot.loader.efi.canTouchEfiVariables = true;

    # Entrada de arranque de Kubuntu
    boot.loader.grub.extraEntries = ''
      menuentry "Zorin OS" {
        insmod part_gpt
        insmod fat
        insmod search_fs_uuid
        insmod chain
        savedefault
        search --fs-uuid --set=root 11C8-1714
        chainloader /EFI/ubuntu/shimx64.efi
      }
    '';

    # ===================== Puntos de montaje =====================

    fileSystems."/mnt/Archivos" = {
      device = "/dev/disk/by-uuid/ec46e7cc-12e7-4e3e-b0f5-fa2876ba2717";
      fsType = "ext4";
      options = ["defaults" "noatime" "nofail" "x-gvfs-show"];
    };

    # ===================== Hardare =====================

    # Distribución de teclado (en X11)
    services.xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "caps:escape_shifted_capslock";
    };

    # Kanata
    services.kanata.keyboards.internalKeyboard.devices = [
      "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
    ];

    # Soporte para touchpad (activado por defecto en muchos desktopManager).
    services.libinput.enable = true;

    # Habilitar lector de huellas
    services.fprintd.enable = true;

    # Perfil de energía y batería
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    # Soporte para redes inalambricas meidante wpa_supplicant
    networking.wireless.enable = true;

    # Bluetooth
    hardware.bluetooth.enable = true;

    # Imprimir documentos usando CUPS
    services.printing.enable = true;

    # ===================== Nombres y rutas =====================

    # Nombre de la máquina
    networking.hostName = "thinkpadx13";

    # Ubicación del flake (necesario para nh)
    environment.sessionVariables = {
      NH_FLAKE = "/home/${mainUser}/denisNixOS/";
    };

    # ===================== Usuarios =====================

    # Definir una cuenta de usuario y contraseña inicial.
    users.users.${mainUser} = {
      isNormalUser = true;
      description = "Denis Pilar";
      extraGroups = ["networkmanager" "wheel"];
      initialPassword = "1234"; # cámbiala con 'passwd'
    };

    # ===================== Entorno de escritorio =====================

    # Habilitar el sistema de ventanas X11
    services.xserver.enable = true;

    # Display Manager de Cinnamon
    services.xserver.displayManager.lightdm.enable = true;

    # ===================== Sistem state version =====================

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.05"; # Did you read the comment?
  };
}
