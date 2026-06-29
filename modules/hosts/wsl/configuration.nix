{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.wslConfiguration = {mainUser, ...}: {
    imports = [
      inputs.nixos-wsl.nixosModules.default
      self.nixosModules.wslPrograms
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Habilitar paquetes no libres (no Open Source)
    nixpkgs.config.allowUnfree = true;

    # ===================== Nombres y rutas =====================

    # Nombre de la máquina
    networking.hostName = "wsl";

    # Ubicación del flake (necesario para nh)
    environment.sessionVariables = {
      NH_FLAKE = "/home/${mainUser}/denisNixOS/";
    };

    # ===================== Usuarios =====================

    # Definir una cuenta de usuario.
    users.users.${mainUser} = {
      isNormalUser = true;
      description = "Denis Pilar";
      extraGroups = ["wheel"];
      initialPassword = "1234"; # Cámbiala con ‘passwd’.
    };

    # ===================== Configuración de NixOS-WSL =====================

    # Edit this configuration file to define what should be installed on
    # your system. Help is available in the configuration.nix(5) man page, on
    # https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

    # NixOS-WSL specific options are documented on the NixOS-WSL repository:
    # https://github.com/nix-community/NixOS-WSL

    wsl.enable = true;
    wsl.defaultUser = mainUser;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.05"; # Did you read the comment?
  };
}
