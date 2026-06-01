{self, ...}: {
  flake.nixosModules.vmguestConfiguration = {
    pkgs,
    mainUser,
    ...
  }: {
    # Importar otros módulos
    imports = [
      self.nixosModules.vmguestHardware
      self.nixosModules.indispensable
      self.nixosModules.doomEmacs
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    # ===================== Boot / Hardare =====================

    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/vda";
    boot.loader.grub.useOSProber = true;

    # Virtualización (guest/invitado)
    services.spice-vdagentd.enable = true;
    services.qemuGuest.enable = true;

    # Distribución de teclado (en X11)
    services.xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
    };

    # Touchpad
    services.libinput.enable = true;

    # ===================== Nombres y rutas =====================

    # Nombre de la máquina
    networking.hostName = "vmguest";

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
    };

    # ===================== Entorno de escritorio =====================

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # ===================== Paquetes / Programas =====================

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      kdePackages.kate
      spice-vdagent
    ];

    # ===================== Sistem state version =====================

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?
  };
}
