{self, ...}: {
  flake.nixosModules.vmguestConfiguration = {
    pkgs,
    mainUser,
    ...
  }: {
    # Importar otros módulos
    imports = [
      # /etc/nixos/hardware-configuration.nix
      self.nixosModules.vmguestHardware
      self.nixosModules.vmguestPrograms
      self.nixosModules.indispensable
      # === Entorno de escritorio ===
      # self.nixosModules.KdePlasma
      self.nixosModules.gnome
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    # ===================== Boot / Hardare =====================

    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/vda";
    boot.loader.grub.useOSProber = true;

    # Distribución de teclado (en X11)
    services.xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "caps:escape_shifted_capslock";
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

    # # Habilitar SDDM (Simple Desktop Display Manager)
    # services.displayManager.sddm.enable = true;

    # Habilitar GDM (Genome Display Manager)
    services.displayManager.gdm.enable = true;

    # ===================== Paquetes / Programas =====================

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      spice-vdagent
    ];

    # ===================== Invitado de Maquina virtual =====================

    # Virtualizando en virtManager
    services.qemuGuest.enable = true;

    # # Portapapales compartido (solo X11)
    # services.spice-vdagentd.enable = true;
    # systemd.user.services.spice-vdagent = {
    #   description = "SPICE vdagent client";
    #   wantedBy = ["graphical-session.target"];
    #   partOf = ["graphical-session.target"];
    #   serviceConfig = {
    #     ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
    #     Restart = "on-failure";
    #   };
    # };

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
